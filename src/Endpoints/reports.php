<?php
$item = new \App\Classes\Reports();

switch ($_SERVER['REQUEST_METHOD']) {
    case 'GET':
        $result = $item->get($_GET);
        \App\Utils\Response::ok($result ?? []);
        break;

    case 'POST':
        $params = json_decode(file_get_contents('php://input'), true);
        if (!isset($params)) {
            \App\Utils\Response::error('Error en la solicitud', 400);
            exit;
        }
        $params = \App\Utils\Response::convertKeysToSnakeCase($params);
        // Attach authenticated user if token was provided
        if (!empty($_SERVER['AUTH_USER_ID'])) {
            $params['user_id'] = (int)$_SERVER['AUTH_USER_ID'];
        }
        \App\Utils\Response::ok(['id' => $item->insert($params)], 201);
        break;

    case 'PATCH':
        $params = json_decode(file_get_contents('php://input'), true);
        if (!isset($params) || !isset($_GET['id']) || empty($_GET['id'])) {
            \App\Utils\Response::error('Error en la solicitud', 400);
            exit;
        }
        $params = \App\Utils\Response::convertKeysToSnakeCase($params);
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
        header('Allow: GET, POST, PATCH, DELETE');
        \App\Utils\Response::error('Método no permitido', 405);
        break;
}
