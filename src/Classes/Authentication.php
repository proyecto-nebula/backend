<?php

namespace App\Classes;

use App\Core\JwtService;
use App\Models\AuthModel;
use App\Utils\Response;
use App\Utils\SecurityLogger;

class Authentication extends AuthModel
{
    private $key;
    private $jwtService;
    private int $tokenTtlSeconds;

    public function __construct()
    {
        $this->key = getenv('JWT_SECRET');
        $ttl = (int) getenv('TOKEN_TTL_SECONDS');
        $this->tokenTtlSeconds = $ttl > 0 ? $ttl : 86400;
        parent::__construct();
        $this->jwtService = new JwtService((string) $this->key);
    }

    /**
     * Método para que un usuario se autentifique con un nombre de usuario y una contraseña
     */
    public function signIn($user)
    {
        // --- Rate limiting por IP con APCu ---
        $ip    = $_SERVER['REMOTE_ADDR'] ?? 'unknown';
        $ipKey = 'rl:ip:' . hash('sha256', $ip);
        if (function_exists('apcu_fetch')) {
            $ipAttempts = apcu_fetch($ipKey) ?: 0;
            if ($ipAttempts >= 10) {
                SecurityLogger::log('RATE_LIMIT_IP_BLOCK', ['email' => $user['email'] ?? '?']);
                Response::error('Demasiados intentos desde esta IP. Inténtelo más tarde.', 429);
                exit;
            }
        }

        // --- Rate limiting por sesión ---
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }
        if (isset($_SESSION['lockout_time']) && (time() - $_SESSION['lockout_time']) < 60) {
            SecurityLogger::log('RATE_LIMIT_SESSION_BLOCK', ['email' => $user['email'] ?? '?']);
            Response::error('Demasiados intentos. Inténtelo de nuevo en 1 minuto.', 429);
            exit;
        }

        if (!isset($user['email']) || !isset($user['password']) || empty($user['email']) || empty($user['password'])) {
            Response::result(400, ['result' => 'error', 'details' => 'Los campos password y el email son obligatorios']);
            exit;
        }

        // Importante: En los datos random que insertamos, las contraseñas no tienen hash.
        // Si vas a usar hash('sha256'...), asegúrate de que en la BD estén hasheadas.
        $result = parent::login($user['email'], hash('sha256', $user['password']));

        if (sizeof($result) == 0) {
            // Incrementar contador por sesión
            $_SESSION['login_attempts'] = ($_SESSION['login_attempts'] ?? 0) + 1;
            if ($_SESSION['login_attempts'] >= 5) {
                $_SESSION['lockout_time'] = time();
                $_SESSION['login_attempts'] = 0;
            }
            // Incrementar contador por IP
            if (function_exists('apcu_add') && function_exists('apcu_inc')) {
                apcu_add($ipKey, 0, 300);
                apcu_inc($ipKey);
            }
            SecurityLogger::log('LOGIN_FAILURE', ['email' => $user['email']]);
            Response::result(403, ['result' => 'error', 'details' => 'El email y/o la contraseña son incorrectas']);
            exit;
        }

        // --- Login exitoso ---
        unset($_SESSION['login_attempts'], $_SESSION['lockout_time']);
        if (function_exists('apcu_delete')) {
            apcu_delete($ipKey);
        }

        $dataToken = [
            'iat'  => time(),
            'exp'  => time() + $this->tokenTtlSeconds,
            'data' => [
                'id'    => $result[0]['id'],
                'email' => $result[0]['email'],
            ],
        ];

        $jwt = $this->jwtService->encode($dataToken);
        parent::update($result[0]['id'], $jwt);

        // Establecer cookie HttpOnly — el token ya no necesita vivir en localStorage
        $this->setTokenCookie($jwt);

        SecurityLogger::log('LOGIN_SUCCESS', ['email' => $user['email'], 'user_id' => $result[0]['id']]);

        return $jwt;
    }

    /** Valida el token de la cookie HttpOnly (con fallback a Authorization header). */
    public function getMe(): array
    {
        $jwt = $_COOKIE['access_token'] ?? '';
        if (empty($jwt)) {
            $authHeader = $_SERVER['HTTP_AUTHORIZATION'] ?? '';
            if (str_starts_with($authHeader, 'Bearer ')) {
                $jwt = substr($authHeader, 7);
            }
        }
        if (empty($jwt)) {
            throw new \Exception('No authenticated');
        }
        return $this->validateToken($jwt);
    }

    /** Invalida la cookie de sesión. */
    public function logout(): void
    {
        SecurityLogger::log('LOGOUT');
        $this->clearCookie();
    }

    private function setTokenCookie(string $jwt): void
    {
        $isProduction = getenv('APP_ENV') === 'production';
        setcookie('access_token', $jwt, [
            'expires'  => time() + $this->tokenTtlSeconds,
            'path'     => '/',
            'secure'   => $isProduction,
            'httponly' => true,
            'samesite' => $isProduction ? 'None' : 'Lax',
        ]);
    }

    private function clearCookie(): void
    {
        $isProduction = getenv('APP_ENV') === 'production';
        setcookie('access_token', '', [
            'expires'  => time() - 3600,
            'path'     => '/',
            'secure'   => $isProduction,
            'httponly' => true,
            'samesite' => $isProduction ? 'None' : 'Lax',
        ]);
    }

    public function validateToken(string $jwt): array
    {
        $payload = $this->jwtService->decode($jwt);
        $claimData = $payload['data'] ?? [];
        if (!is_array($claimData) || !isset($claimData['id'])) {
            throw new \Exception('Invalid claims');
        }

        $user = parent::getById($claimData['id']);
        if (empty($user) || $user[0]['token'] != $jwt) {
            throw new \Exception('Token mismatch');
        }

        $lastLoginAt = $user[0]['last_login_at'] ?? null;
        if (empty($lastLoginAt)) {
            throw new \Exception('Missing last login timestamp');
        }

        $lastLoginTs = strtotime((string) $lastLoginAt);
        if ($lastLoginTs === false) {
            throw new \Exception('Invalid last login timestamp');
        }

        if ((time() - $lastLoginTs) > $this->tokenTtlSeconds) {
            throw new \Exception('Token expired');
        }

        return [
            'id' => (string) $claimData['id'],
            'email' => (string) ($claimData['email'] ?? '')
        ];
    }
}