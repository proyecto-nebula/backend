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
        \App\Utils\Response::ok($item->get($_GET));
        break;

    case 'POST':
        $params = json_decode(file_get_contents('php://input'), true);
        if (!isset($params)) {
            \App\Utils\Response::error('Error en la solicitud', 400);
            exit;
        }
        \App\Utils\Response::ok(['id' => $item->insert($params)], 201);
        break;

    case 'PUT':
        $params = json_decode(file_get_contents('php://input'), true);
        if (!isset($params) || !isset($_GET['id']) || empty($_GET['id'])) {
            \App\Utils\Response::error('Error en la solicitud', 400);
            exit;
        }
        $item->updatePut($_GET['id'], $params);
        \App\Utils\Response::ok();
        break;

    case 'PATCH':
        $params = json_decode(file_get_contents('php://input'), true);
        if (!isset($params) || !isset($_GET['id']) || empty($_GET['id'])) {
            \App\Utils\Response::error('Error en la solicitud', 400);
            exit;
        }
        $item->updatePatch($_GET['id'], $params);
        \App\Utils\Response::ok();
        break;

    case 'DELETE':
        if (!isset($_GET['id']) || empty($_GET['id'])) {
            \App\Utils\Response::error('Error en la solicitud', 400);
            exit;
        }
        $item->delete($_GET['id']);
        \App\Utils\Response::ok();
        break;

    default:
        header('Allow: GET, POST, PUT, PATCH, DELETE');
        \App\Utils\Response::error('Método no permitido', 405);
        break;
}
?>