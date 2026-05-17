<?php
/**
 * Script para trabajar con registros de la tabla favorites
 */
$item = new \App\Classes\Favorites();

switch ($_SERVER['REQUEST_METHOD']) {
    case 'GET':
        \App\Utils\Response::ok($item->get($_GET));
        break;

    case 'POST':
        $params = json_decode(file_get_contents('php://input'), true);
        $params = \App\Utils\Response::convertKeysToSnakeCase($params);
        \App\Utils\Response::ok(['id' => $item->insert($params)], 201);
        break;

    case 'DELETE':
        // game_id viene de la URL (/api/v1/favorites/{id}), user_id del token JWT
        if (!isset($_GET['id']) || $_GET['id'] === '' || $_GET['id'] === null) {
            \App\Utils\Response::error('Falta el id del juego en la ruta', 400);
            exit;
        }
        $userId = $_SERVER['AUTH_USER_ID'] ?? null;
        // Use strict check: empty() treats "0" as empty, which breaks user id=0
        if ($userId === null || $userId === '') {
            \App\Utils\Response::error('No se pudo determinar el usuario autenticado', 401);
            exit;
        }
        $item->deleteFavorito((int) $userId, (int) $_GET['id']);
        \App\Utils\Response::ok();
        break;

    default:
        header('Allow: GET, POST, DELETE');
        \App\Utils\Response::error('Método no permitido', 405);
        break;
}
