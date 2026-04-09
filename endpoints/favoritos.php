<?php
/**
 * Script para trabajar con registros de la tabla FAVORITOS
 */
require_once  __DIR__ . '/../src/utils/response.php';
require_once __DIR__ . '/../src/classes/auth.class.php';
require_once __DIR__ . '/../src/classes/favoritos.class.php';

$auth = new Authentication();
$auth->verify();
$item = new favoritos();

switch ($_SERVER['REQUEST_METHOD']) {
    case 'GET':
        $items = $item->get($_GET);
        Response::result(200, array('result' => 'ok', 'items' => $items));
        break;
        
    case 'POST':
        $params = json_decode(file_get_contents('php://input'), true);
        $insert_id = $item->insert($params);
        Response::result(201, array('result' => 'ok', 'insert_id' => $insert_id));
        break;


    case 'DELETE':
        // Validamos que vengan AMBOS parámetros
        if(!isset($_GET['id_usuario']) || !isset($_GET['id_juego'])){
            Response::result(400, array('result' => 'error', 'details' => 'Falta id_usuario o id_juego'));
            exit;
        }
        
        // Pasamos ambos al método delete
        $item->deleteFavorito($_GET['id_usuario'], $_GET['id_juego']);
        Response::result(200, array('result' => 'ok', 'details' => 'Favorito eliminado'));
        break;

    default:
        Response::result(404, array('result' => 'error'));
        break;
}
