<?php
/**
 * Script que se usa en los endpoints para trabajar con registros de la tabla CAPTURAS
 * La clase "CAPTURAS.class.php" es la clase del modelo, que representa a un item de la tabla
*/
require_once  __DIR__ . '/../src/utils/response.php';
require_once __DIR__ . '/../src/classes/auth.class.php';
require_once __DIR__ . '/../src/classes/categorias.class.php';

$auth = new Authentication();
$auth->verify();

$item = new categorias();

/**
 * Se mira el tipo de petición que ha llegado a la API y dependiendo de ello se realiza una u otra accción
 */
switch ($_SERVER['REQUEST_METHOD']) {
    case 'GET':
        $params = $_GET;
        $items = $item->get($params);
        $response = array('result' => 'ok', 'items' => $items);
        Response::result(200, $response);
        break;
        
    case 'POST':
        $params = json_decode(file_get_contents('php://input'), true);
        if(!isset($params)){
            Response::result(400, array('result' => 'error', 'details' => 'Error en la solicitud'));
            exit;
        }
        $insert_id = $item->insert($params);
        Response::result(201, array('result' => 'ok', 'insert_id' => $insert_id));
        break;

    case 'PUT':
        $params = json_decode(file_get_contents('php://input'), true);
        if(!isset($params) || !isset($_GET['id_captura']) || empty($_GET['id_captura'])){
            Response::result(400, array('result' => 'error', 'details' => 'Error en la solicitud'));
            exit;
        }
        $item->updatePut($_GET['id_captura'], $params);
        Response::result(200, array('result' => 'ok'));
        break;

    case 'PATCH':
        $params = json_decode(file_get_contents('php://input'), true);
        if(!isset($params) || !isset($_GET['id_captura']) || empty($_GET['id_captura'])){
            Response::result(400, array('result' => 'error', 'details' => 'Error en la solicitud'));
            exit;
        }
        $item->updatePatch($_GET['id_captura'], $params);
        Response::result(200, array('result' => 'ok'));
        break;

    case 'DELETE':
        if(!isset($_GET['id_captura']) || empty($_GET['id_captura'])){
            Response::result(400, array('result' => 'error', 'details' => 'Error en la solicitud'));
            exit;
        }
        $item->delete($_GET['id_captura']);
        Response::result(200, array('result' => 'ok'));
        break;

    default:
        Response::result(404, array('result' => 'error'));
        break;
}
?>