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
        Response::result(200, array('result' => 'ok', 'items' => $item->get($_GET)));
        break;
    case 'POST':
        $insert_id = $item->insert(json_decode(file_get_contents('php://input'), true));
        Response::result(201, array('result' => 'ok'));
        break;
    case 'DELETE':
        // Para borrar un favorito necesitamos ambos IDs en la URL
        if(!isset($_GET['id_usuario']) || !isset($_GET['id_juego'])){
            Response::result(400, array('result' => 'error', 'details' => 'Faltan IDs'));
            exit;
        }
        // Aquí llamarías a un método personalizado de borrado
        Response::result(200, array('result' => 'ok'));
        break;
    default:
        Response::result(404, array('result' => 'error'));
        break;
}
