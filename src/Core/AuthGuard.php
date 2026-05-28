<?php

namespace App\Core;

use App\Classes\Authentication;
use App\Utils\Response;
use App\Utils\SecurityLogger;

class AuthGuard
{
    // Endpoints públicos (no requieren autenticación)
    private const PUBLIC_ENDPOINTS = [
        'auth', 'test', 'games', 'studios', 'screenshots', 'roles', 'plans', 'pegi', 'game_categories', 'categories', 'avatars'
    ];

    public static function enforce(string $resource): void
    {
        // Allow public registration: POST /api/v1/users should be accessible without token
        if ($resource === 'users' && ($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
            return;
        }

        // Allow public report submission: POST /api/v1/reports
        if ($resource === 'reports' && ($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
            return;
        }

        if (in_array($resource, self::PUBLIC_ENDPOINTS, true)) {
            return;
        }

        // 1) Intentar token desde cookie HttpOnly
        $token = $_COOKIE['access_token'] ?? '';

        // 2) Fallback: header Authorization (clientes de API / Postman)
        if (empty($token)) {
            $authHeader = $_SERVER['HTTP_AUTHORIZATION'] ?? '';
            if (empty($authHeader)) {
                $authHeader = $_SERVER['REDIRECT_HTTP_AUTHORIZATION'] ?? '';
            }
            if (empty($authHeader)) {
                $authHeader = $_SERVER['Authorization'] ?? '';
            }
            if (empty($authHeader) && function_exists('apache_request_headers')) {
                $headers = apache_request_headers();
                $authHeader = $headers['Authorization'] ?? $headers['authorization'] ?? '';
            }
            if (empty($authHeader) && function_exists('getallheaders')) {
                $headers = getallheaders();
                $authHeader = $headers['Authorization'] ?? $headers['authorization'] ?? '';
            }
            if (str_starts_with($authHeader, 'Bearer ')) {
                $token = substr($authHeader, 7);
            }
        }

        if (empty($token)) {
            Response::result(401, [
                'result'  => 'error',
                'data'    => null,
                'message' => 'Usted no tiene los permisos para esta solicitud'
            ]);
            exit;
        }

        try {
            $auth = new Authentication();
            $data = $auth->validateToken($token);

            // Exponer datos de usuario autenticado para su uso en endpoints si hace falta.
            $_SERVER['AUTH_USER_ID'] = (string) ($data['id'] ?? '');
            $_SERVER['AUTH_USER_EMAIL'] = (string) ($data['email'] ?? '');
        } catch (\Throwable $th) {
            SecurityLogger::log('TOKEN_INVALID');
            Response::result(401, [
                'result'  => 'error',
                'data'    => null,
                'message' => 'Token invalido o expirado'
            ]);
            exit;
        }
    }
}
