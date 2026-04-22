<?php
/**
 * Script que se usa en los endpoints para trabajar con registros de la tabla PEGI
 */
$item = new \App\Classes\Pegi();

switch ($_SERVER['REQUEST_METHOD']) {
    case 'GET':
        $items = $item->get($_GET);
        \App\Utils\Response::result(200, array('result' => 'ok', 'items' => $items));
        break;
    case 'POST':
        $insert_id = $item->insert(json_decode(file_get_contents('php://input'), true));
        \App\Utils\Response::result(201, array('result' => 'ok', 'insert_id' => $insert_id));
        break;
    case 'PUT':
        $item->updatePut($_GET['id'], json_decode(file_get_contents('php://input'), true));
        \App\Utils\Response::result(200, array('result' => 'ok'));
        break;
    case 'PATCH':
        $item->updatePatch($_GET['id'], json_decode(file_get_contents('php://input'), true));
        \App\Utils\Response::result(200, array('result' => 'ok'));
        break;
    case 'DELETE':
        $item->delete($_GET['id']);
        \App\Utils\Response::result(200, array('result' => 'ok'));
        break;
    default:
        \App\Utils\Response::result(404, array('result' => 'error'));
        break;
}