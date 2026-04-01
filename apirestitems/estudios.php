<?php
/**
 * Script que se usa en los endpoints para trabajar con registros de la tabla ESTUDIOS
 */
require_once 'src/response.php';
require_once 'src/classes/auth.class.php';
require_once 'src/classes/ESTUDIOS.class.php';

$auth = new Authentication();
$auth->verify();

$item = new ESTUDIOS();

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

    case 'PUT':
        $params = json_decode(file_get_contents('php://input'), true);
        $item->updatePut($_GET['id_estudio'], $params);
        Response::result(200, array('result' => 'ok'));
        break;

    case 'PATCH':
        $params = json_decode(file_get_contents('php://input'), true);
        $item->updatePatch($_GET['id_estudio'], $params);
        Response::result(200, array('result' => 'ok'));
        break;

    case 'DELETE':
        $item->delete($_GET['id_estudio']);
        Response::result(200, array('result' => 'ok'));
        break;

    default:
        Response::result(404, array('result' => 'error'));
        break;
}
?>