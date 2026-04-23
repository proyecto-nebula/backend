<?php
/**
 * Script para trabajar con registros de la tabla game_categories
 */
$item = new \App\Classes\GameCategories();


switch ($_SERVER['REQUEST_METHOD']) {
    case 'GET':
        \App\Utils\Response::ok($item->get($_GET));
        break;
    case 'POST':
        \App\Utils\Response::ok(['id' => $item->insert(json_decode(file_get_contents('php://input'), true))], 201);
        break;
    case 'DELETE':
        if (!isset($_GET['game_id']) || !isset($_GET['category_id'])) {
            \App\Utils\Response::error('Faltan parámetros (game_id y category_id)', 400);
            exit;
        }
        $item->deleteRelacion($_GET['game_id'], $_GET['category_id']);
        \App\Utils\Response::ok();
        break;
    default:
        header('Allow: GET, POST, DELETE');
        \App\Utils\Response::error('Método no permitido', 405);
        break;
}
?>
