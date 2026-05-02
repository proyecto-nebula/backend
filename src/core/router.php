<?php
namespace App\Core;
// Router.php

use App\Utils\Response;

class Router {
    private static $endpoints = [
        'users', 'games', 'avatars', 'screenshots', 'categories', 
        'studios', 'favorites', 'game_categories', 'sessions', 
        'pegi', 'roles', 'plans', 'auth', 'test', 'test_encoding', 'test_db_encoding_api'
    ];

    public static function dispatch($uri) {
        $apiPrefix = '/api/v1/';
        $path = parse_url($uri, PHP_URL_PATH);
        $pos = strpos($path, $apiPrefix);

        if ($pos === false) {
            Response::error('Prefijo api/v1 no encontrado', 404);
            exit;
        }

        $route = substr($path, $pos + strlen($apiPrefix));
        $parts = explode('/', trim($route, '/'));

        $resource = $parts[0] ?? null;
        $id = $parts[1] ?? null;

        if (!in_array($resource, self::$endpoints)) {
            Response::error('Recurso no válido', 404);
            exit;
        }

        if ($id) {
            // Normalizar id a entero para evitar inyecciones y inconsistencias
            $_GET['id'] = intval($id);
        }

        // Permitir acceso público a test y test_encoding
        if (!in_array($resource, ['test', 'test_encoding'])) {
            AuthGuard::enforce((string) $resource);
        }

        // Cargar el archivo del endpoint (ruta segura)
        $endpointsDir = realpath(dirname(__DIR__) . '/Endpoints');
        if ($endpointsDir === false) {
            Response::error('Configuración del servidor inválida', 500);
            exit;
        }

        $file = $endpointsDir . DIRECTORY_SEPARATOR . $resource . '.php';
        $realFile = realpath($file);

        // Comprobar existencia y evitar traversal
        if ($realFile === false || strpos($realFile, $endpointsDir) !== 0 || !file_exists($realFile)) {
            Response::error('Endpoint no implementado', 404);
            exit;
        }

        require_once $realFile;
    }
}