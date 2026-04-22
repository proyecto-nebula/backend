<?php
namespace App\Core;
// Router.php

class Router {
    private static $endpoints = [
        'users', 'games', 'avatars', 'screenshots', 'categories', 
        'studios', 'favorites', 'game_categories', 'sessions', 
        'pegi', 'roles', 'plans', 'auth', 'test'
    ];

    public static function dispatch($uri) {
        $apiPrefix = '/api/v1/';
        $path = parse_url($uri, PHP_URL_PATH);
        $pos = strpos($path, $apiPrefix);

        if ($pos === false) {
            self::jsonResponse(404, ['error' => 'Prefijo api/v1 no encontrado']);
        }

        $route = substr($path, $pos + strlen($apiPrefix));
        $parts = explode('/', trim($route, '/'));

        $resource = $parts[0] ?? null;
        $id = $parts[1] ?? null;

        if (!in_array($resource, self::$endpoints)) {
            self::jsonResponse(404, ['error' => 'Recurso no válido']);
        }

        if ($id) {
            // Normalizar id a entero para evitar inyecciones y inconsistencias
            $_GET['id'] = intval($id);
        }

        AuthGuard::enforce((string) $resource);

        // Cargar el archivo del endpoint (ruta segura)
        $endpointsDir = realpath(dirname(__DIR__) . '/Endpoints');
        if ($endpointsDir === false) {
            self::jsonResponse(500, ['error' => 'Configuración del servidor inválida']);
        }

        $file = $endpointsDir . DIRECTORY_SEPARATOR . $resource . '.php';
        $realFile = realpath($file);

        // Comprobar existencia y evitar traversal
        if ($realFile === false || strpos($realFile, $endpointsDir) !== 0 || !file_exists($realFile)) {
            self::jsonResponse(404, ['error' => 'Endpoint no implementado']);
        }

        require_once $realFile;
    }

    private static function jsonResponse($code, $data) {
        http_response_code($code);
        header('Content-Type: application/json');
        echo json_encode($data);
        exit;
    }
}