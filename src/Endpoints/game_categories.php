<?php
/**
 * Script para trabajar con registros de la tabla game_categories
 */
$item = new \App\Classes\GameCategories();


switch ($_SERVER['REQUEST_METHOD']) {
    case 'GET':
        \App\Utils\Response::result(200, array('result' => 'ok', 'items' => $item->get($_GET)));
        break;
    case 'POST':
        $item->insert(json_decode(file_get_contents('php://input'), true));
        \App\Utils\Response::result(201, array('result' => 'ok'));
        break;
    case 'DELETE':
        // Verificamos que lleguen ambos parámetros por la URL
        if(!isset($_GET['game_id']) || !isset($_GET['category_id'])){
            \App\Utils\Response::result(400, array('result' => 'error', 'details' => 'Faltan parámetros (game_id e category_id)'));
            exit;
        }
        
        // Llamamos al método correcto que está en tu clase
        $item->deleteRelacion($_GET['game_id'], $_GET['category_id']);
        
        \App\Utils\Response::result(200, array('result' => 'ok'));
        break;
    default:
        \App\Utils\Response::result(404, array('result' => 'error'));
        break;
}
?>
