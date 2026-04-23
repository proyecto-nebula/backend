<?php

namespace App\Core;

use App\Classes\Authentication;
use App\Utils\Response;

class AuthGuard
{
    private const PUBLIC_ENDPOINTS = ['auth', 'test'];

    public static function enforce(string $resource): void
    {
        if (in_array($resource, self::PUBLIC_ENDPOINTS, true)) {
            return;
        }

        $authHeader = $_SERVER['HTTP_AUTHORIZATION'] ?? '';

        // Fallback: Apache a veces no pasa HTTP_AUTHORIZATION a $_SERVER
        if (empty($authHeader) && function_exists('apache_request_headers')) {
            $headers = apache_request_headers();
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
