<?php
/**
 * Script que se usa en los endpoints para trabajar con registros de la tabla screenshots
 * La clase "screenshots.class.php" es la clase del modelo, que representa a un item de la tabla
*/
$item = new \App\Classes\Screenshots();

/**
 * Se mira el tipo de petición que ha llegado a la API y dependiendo de ello se realiza una u otra accción
 */
switch ($_SERVER['REQUEST_METHOD']) {
    case 'GET':
        $params = $_GET;
        $items = $item->get($params);
        $response = array('result' => 'ok', 'items' => $items);
        \App\Utils\Response::result(200, $response);
        break;
        
    case 'POST':
        $params = json_decode(file_get_contents('php://input'), true);
        if(!isset($params)){
            \App\Utils\Response::result(400, array('result' => 'error', 'details' => 'Error en la solicitud'));
            exit;
        }
        $insert_id = $item->insert($params);
        \App\Utils\Response::result(201, array('result' => 'ok', 'insert_id' => $insert_id));
        break;

    case 'PUT':
        $params = json_decode(file_get_contents('php://input'), true);
        if(!isset($params) || !isset($_GET['id']) || empty($_GET['id'])){
            \App\Utils\Response::result(400, array('result' => 'error', 'details' => 'Error en la solicitud'));
            exit;
        }
        $item->updatePut($_GET['id'], $params);
        \App\Utils\Response::result(200, array('result' => 'ok'));
        break;

    case 'PATCH':
        $params = json_decode(file_get_contents('php://input'), true);
        if(!isset($params) || !isset($_GET['id']) || empty($_GET['id'])){
            \App\Utils\Response::result(400, array('result' => 'error', 'details' => 'Error en la solicitud'));
            exit;
        }
        $item->updatePatch($_GET['id'], $params);
        \App\Utils\Response::result(200, array('result' => 'ok'));
        break;

    case 'DELETE':
        if(!isset($_GET['id']) || empty($_GET['id'])){
            \App\Utils\Response::result(400, array('result' => 'error', 'details' => 'Error en la solicitud'));
            exit;
        }
        $item->delete($_GET['id']);
        \App\Utils\Response::result(200, array('result' => 'ok'));
        break;

    default:
        \App\Utils\Response::result(404, array('result' => 'error'));
        break;
}
?>