<?php
/**
 * Script para trabajar con registros de la tabla favorites
 */
$item = new \App\Classes\Favorites();

switch ($_SERVER['REQUEST_METHOD']) {
    case 'GET':
        $items = $item->get($_GET);
        \App\Utils\Response::result(200, array('result' => 'ok', 'items' => $items));
        break;
        
    case 'POST':
        $params = json_decode(file_get_contents('php://input'), true);
        $insert_id = $item->insert($params);
        \App\Utils\Response::result(201, array('result' => 'ok', 'insert_id' => $insert_id));
        break;


    case 'DELETE':
        // Validamos que vengan AMBOS parámetros
        if(!isset($_GET['user_id']) || !isset($_GET['game_id'])){
            \App\Utils\Response::result(400, array('result' => 'error', 'details' => 'Falta user_id o game_id'));
            exit;
        }
        
        // Pasamos ambos al método delete
        $item->deleteFavorito($_GET['user_id'], $_GET['game_id']);
        \App\Utils\Response::result(200, array('result' => 'ok', 'details' => 'Favorito eliminado'));
        break;

    default:
        \App\Utils\Response::result(404, array('result' => 'error'));
        break;
}
