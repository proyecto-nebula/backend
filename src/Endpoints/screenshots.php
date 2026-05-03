<?php
/**
 * Endpoint de screenshots: devuelve las capturas de un juego desde la API de IGDB.
 * GET /api/v1/screenshots/{id}
 */
$item = new \App\Classes\Screenshots();

switch ($_SERVER['REQUEST_METHOD']) {
    case 'GET':
        \App\Utils\Response::ok($item->get($_GET));
        break;

    default:
        header('Allow: GET');
        \App\Utils\Response::error('Método no permitido', 405);
        break;
}
