<?php

namespace App\Core;

use App\Classes\Authentication;
use App\Utils\Response;

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

        // Allow unauthenticated listing of users (used by the dev debug panel; never shown in production)
        if ($resource === 'users' && ($_SERVER['REQUEST_METHOD'] ?? '') === 'GET') {
            return;
        }

        // Allow public report submission: POST /api/v1/reports
        if ($resource === 'reports' && ($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
            return;
        }

        if (in_array($resource, self::PUBLIC_ENDPOINTS, true)) {
            return;
        }

        $authHeader = $_SERVER['HTTP_AUTHORIZATION'] ?? '';

        // Apache may deliver the header under several different keys depending on
        // configuration (mod_rewrite REDIRECT_ prefix, CGI passthrough, etc.).
        // Check all known variants before falling back to apache_request_headers().
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

        if (empty($authHeader) || !str_starts_with($authHeader, 'Bearer ')) {
            Response::result(401, [
                'result'  => 'error',
                'data'    => null,
                'message' => 'Usted no tiene los permisos para esta solicitud (Falta Authorization Bearer)'
            ]);
            exit;
        }

        $token = substr($authHeader, 7);

        try {
            $auth = new Authentication();
            $data = $auth->validateToken($token);

            // Exponer datos de usuario autenticado para su uso en endpoints si hace falta.
            $_SERVER['AUTH_USER_ID'] = (string) ($data['id'] ?? '');
            $_SERVER['AUTH_USER_EMAIL'] = (string) ($data['email'] ?? '');
        } catch (\Throwable $th) {
            Response::result(401, [
                'result'  => 'error',
                'data'    => null,
                'message' => 'Token invalido o expirado'
            ]);
            exit;
        }
    }
}
