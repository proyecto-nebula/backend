<?php
/**
 * Script para trabajar con registros de la tabla JUEGOS_IDIOMAS
 */
require_once 'src/response.php';
require_once 'src/classes/auth.class.php';
require_once 'src/classes/JUEGOS_IDIOMAS.class.php';

$auth = new Authentication();
$auth->verify();

$item = new JUEGOS_IDIOMAS();

switch ($_SERVER['REQUEST_METHOD']) {
    case 'GET':
        Response::result(200, array('result' => 'ok', 'items' => $item->get($_GET)));
        break;
    case 'POST':
        $item->insert(json_decode(file_get_contents('php://input'), true));
        Response::result(201, array('result' => 'ok'));
        break;
    case 'DELETE':
        $item->delete($_GET['id_juego']);
        Response::result(200, array('result' => 'ok'));
        break;
    default:
        Response::result(404, array('result' => 'error'));
        break;
}
?>