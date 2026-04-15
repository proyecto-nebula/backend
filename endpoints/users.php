<?php

/**
 * Script que se usa en los endpoints para trabajar con registros de la tabla USUARIOS
 */
require_once  __DIR__ . '/../src/utils/response.php';
require_once __DIR__ . '/../src/classes/auth.class.php';
require_once __DIR__ . '/../src/classes/usuarios.class.php';

$auth = new Authentication();
$auth->verify();

$item = new usuarios();

/**
 * Se mira el tipo de petición que ha llegado a la API
 */
switch ($_SERVER['REQUEST_METHOD']) {
    case 'GET':
        $params = $_GET;
        
        // Si en la URL viene el parámetro id_usuario (ej: ?id_usuario=1)
        if (isset($params['id_usuario']) && !empty($params['id_usuario'])) {
            $userData = $item->getPerfilCompleto($params['id_usuario']);
            
            if ($userData) {
                Response::result(200, array('result' => 'ok', 'usuario' => $userData));
            } else {
                Response::result(404, array('result' => 'error', 'details' => 'Usuario no encontrado'));
            }
        } else {
            // Si no viene ID, funciona como antes (lista general)
            $items = $item->get($params);
            $response = array('result' => 'ok', 'items' => $items);
            Response::result(200, $response);
        }
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
        if(!isset($params) || !isset($_GET['id_usuario']) || empty($_GET['id_usuario'])){
            Response::result(400, array('result' => 'error', 'details' => 'Error en la solicitud'));
            exit;
        }
        $item->updatePut($_GET['id_usuario'], $params);
        Response::result(200, array('result' => 'ok'));
        break;

    case 'PATCH':
        $params = json_decode(file_get_contents('php://input'), true);
        if(!isset($params) || !isset($_GET['id_usuario']) || empty($_GET['id_usuario'])){
            Response::result(400, array('result' => 'error', 'details' => 'Error en la solicitud'));
            exit;
        }
        $item->updatePatch($_GET['id_usuario'], $params);
        Response::result(200, array('result' => 'ok'));
        break;

    case 'DELETE':
        if(!isset($_GET['id_usuario']) || empty($_GET['id_usuario'])){
            Response::result(400, array('result' => 'error', 'details' => 'Error en la solicitud'));
            exit;
        }
        $item->delete($_GET['id_usuario']);
        Response::result(200, array('result' => 'ok'));
        break;

    default:
        Response::result(404, array('result' => 'error'));
        break;
}
?>