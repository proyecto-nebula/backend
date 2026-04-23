<?php
/**
 * Script que se usa en los endpoints para trabajar con registros de la tabla PEGI
 */
$item = new \App\Classes\Pegi();

switch ($_SERVER['REQUEST_METHOD']) {
    case 'GET':
        \App\Utils\Response::ok($item->get($_GET));
        break;
    case 'POST':
        \App\Utils\Response::ok(['id' => $item->insert(json_decode(file_get_contents('php://input'), true))], 201);
        break;
    case 'PUT':
        $item->updatePut($_GET['id'], json_decode(file_get_contents('php://input'), true));
        \App\Utils\Response::ok();
        break;
    case 'PATCH':
        $item->updatePatch($_GET['id'], json_decode(file_get_contents('php://input'), true));
        \App\Utils\Response::ok();
        break;
    case 'DELETE':
        $item->delete($_GET['id']);
        \App\Utils\Response::ok();
        break;
    default:
        header('Allow: GET, POST, PUT, PATCH, DELETE');
        \App\Utils\Response::error('Método no permitido', 405);
        break;
}