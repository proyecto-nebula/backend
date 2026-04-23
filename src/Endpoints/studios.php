<?php
/**
 * Script que se usa en los endpoints para trabajar con registros de la tabla STUDIOS
 */
$item = new \App\Classes\Studios();

switch ($_SERVER['REQUEST_METHOD']) {
    case 'GET':
        \App\Utils\Response::ok($item->get($_GET));
        break;

    case 'POST':
        $params = json_decode(file_get_contents('php://input'), true);
        \App\Utils\Response::ok(['id' => $item->insert($params)], 201);
        break;

    case 'PUT':
        $params = json_decode(file_get_contents('php://input'), true);
        $item->updatePut($_GET['id'], $params);
        \App\Utils\Response::ok();
        break;

    case 'PATCH':
        $params = json_decode(file_get_contents('php://input'), true);
        $item->updatePatch($_GET['id'], $params);
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
?>
