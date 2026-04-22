<?php
/**
 * Script que se usa en los endpoints para trabajar con registros de la tabla games
 * La clase "games.class.php" es la clase del modelo, que representa a un item de la tabla
*/
$item = new \App\Classes\Games();

/**
 * Se mira el tipo de petición que ha llegado a la API y dependiendo de ello se realiza una u otra accción
 */
switch ($_SERVER['REQUEST_METHOD']) {
    /**
     * Si se ha recibido un GET se llama al método get() del modelo y se le pasan los parámetros recibidos por GET en la petición
     */
    case 'GET':
        $params = $_GET;

        $items = $item->get($params);

        $response = array(
            'result' => 'ok',
            'items' => $items
        );

        \App\Utils\Response::result(200, $response);
        break;
        
    /**
     * Si se recibe un POST, se comprueba si se han recibido parámetros y en caso afirmativo se usa el método insert() del modelo
     */
    case 'POST':
        $params = json_decode(file_get_contents('php://input'), true);

        if(!isset($params)){
            $response = array(
                'result' => 'error',
                'details' => 'Error en la solicitud'
            );

            \App\Utils\Response::result(400, $response);
            exit;
        }

        $insert_id = $item->insert($params);

        $response = array(
            'result' => 'ok',
            'insert_id' => $insert_id
        );

        \App\Utils\Response::result(201, $response);
        break;

    /**
     * Cuando es PUT, comprobamos si la petición lleva el id del item que hay que actualizar. En caso afirmativo se usa el método updatePut() del modelo.
     * En PUT hay que enviar todos los datos del registro, aunque no se cambien
     */
    case 'PUT':
        $params = json_decode(file_get_contents('php://input'), true);

        if(!isset($params) || !isset($_GET['id']) || empty($_GET['id'])){
            $response = array(
                'result' => 'error',
                'details' => 'Error en la solicitud'
            );

            \App\Utils\Response::result(400, $response);
            exit;
        }

        $item->updatePut($_GET['id'], $params);

        $response = array(
            'result' => 'ok'
        );

        \App\Utils\Response::result(200, $response);
        break;

    /**
     * Cuando es PATCH, comprobamos si la petición lleva el id del item que hay que actualizar. En caso afirmativo se usa el método updatePatch() del modelo.
     * En PATCH no es necesario enviar todos los datos del registro, unicamente los que cambian
     */
    case 'PATCH':
        $params = json_decode(file_get_contents('php://input'), true);

        if(!isset($params) || !isset($_GET['id']) || empty($_GET['id'])){
            $response = array(
                'result' => 'error',
                'details' => 'Error en la solicitud'
            );

            \App\Utils\Response::result(400, $response);
            exit;
        }

        $item->updatePatch($_GET['id'], $params);

        $response = array(
            'result' => 'ok'
        );

        \App\Utils\Response::result(200, $response);
        break;

    /**
     * Cuando se solicita un DELETE se comprueba que se envíe un id de juego. En caso afirmativo se utiliza el método delete() del modelo.
     */
    case 'DELETE':
        if(!isset($_GET['id']) || empty($_GET['id'])){
            $response = array(
                'result' => 'error',
                'details' => 'Error en la solicitud'
            );

            \App\Utils\Response::result(400, $response);
            exit;
        }

        $item->delete($_GET['id']);

        $response = array(
            'result' => 'ok'
        );

        \App\Utils\Response::result(200, $response);
        break;

    /**
     * Para cualquier otro tipo de petición se devuelve un mensaje de error 404.
     */
    default:
        $response = array(
            'result' => 'error'
        );

        \App\Utils\Response::result(404, $response);
        break;
}
?>