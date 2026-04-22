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

        if (!isset($_SERVER['HTTP_API_KEY']) || empty($_SERVER['HTTP_API_KEY'])) {
            Response::result(403, [
                'result' => 'error',
                'details' => 'Usted no tiene los permisos para esta solicitud (Falta API-KEY)'
            ]);
            exit;
        }

        try {
            $auth = new Authentication();
            $data = $auth->validateToken($_SERVER['HTTP_API_KEY']);

            // Exponer datos de usuario autenticado para su uso en endpoints si hace falta.
            $_SERVER['AUTH_USER_ID'] = (string) ($data['id'] ?? '');
            $_SERVER['AUTH_USER_EMAIL'] = (string) ($data['email'] ?? '');
        } catch (\Throwable $th) {
            Response::result(403, [
                'result' => 'error',
                'details' => 'Token invalido o expirado'
            ]);
            exit;
        }
    }
}
