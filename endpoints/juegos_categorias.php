<?php
/**
 * Script para trabajar con registros de la tabla JUEGOS_CATEGORIAS
 */
require_once  __DIR__ . '/../src/utils/response.php';
require_once __DIR__ . '/../src/classes/auth.class.php';
require_once __DIR__ . '/../src/classes/juegos_categorias.class.php';

$auth = new Authentication();
$auth->verify();

$item = new juegos_categorias();


switch ($_SERVER['REQUEST_METHOD']) {
    case 'GET':
        Response::result(200, array('result' => 'ok', 'items' => $item->get($_GET)));
        break;
    case 'POST':
        $item->insert(json_decode(file_get_contents('php://input'), true));
        Response::result(201, array('result' => 'ok'));
        break;
    case 'DELETE':
        // Verificamos que lleguen ambos parámetros por la URL
        if(!isset($_GET['id_juego']) || !isset($_GET['id_categoria'])){
            Response::result(400, array('result' => 'error', 'details' => 'Faltan parámetros (id_juego e id_categoria)'));
            exit;
        }
        
        // Llamamos al método correcto que está en tu clase
        $item->deleteRelacion($_GET['id_juego'], $_GET['id_categoria']);
        
        Response::result(200, array('result' => 'ok'));
        break;
    default:
        Response::result(404, array('result' => 'error'));
        break;
}
?>
