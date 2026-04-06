<?php
/**
 * Script que se usa en los endpoints para trabajar con registros de la tabla PEGI
 */
require_once 'src/response.php';
require_once 'src/classes/auth.class.php';
require_once 'src/classes/PEGI.class.php';

$auth = new Authentication();
$auth->verify();

$item = new PEGI();

switch ($_SERVER['REQUEST_METHOD']) {
    case 'GET':
        $items = $item->get($_GET);
        Response::result(200, array('result' => 'ok', 'items' => $items));
        break;
    case 'POST':
        $insert_id = $item->insert(json_decode(file_get_contents('php://input'), true));
        Response::result(201, array('result' => 'ok', 'insert_id' => $insert_id));
        break;
    case 'PUT':
        $item->updatePut($_GET['id_pegi'], json_decode(file_get_contents('php://input'), true));
        Response::result(200, array('result' => 'ok'));
        break;
    case 'PATCH':
        $item->updatePatch($_GET['id_pegi'], json_decode(file_get_contents('php://input'), true));
        Response::result(200, array('result' => 'ok'));
        break;
    case 'DELETE':
        $item->delete($_GET['id_pegi']);
        Response::result(200, array('result' => 'ok'));
        break;
    default:
        Response::result(404, array('result' => 'error'));
        break;
}