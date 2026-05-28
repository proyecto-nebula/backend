<?php

/**
 * Endpoint de logs de seguridad — solo accesible para administradores (role_id = 1).
 * GET    /api/v1/logs  → devuelve las últimas entradas del log
 * DELETE /api/v1/logs  → limpia el log
 */

use App\Utils\SecurityLogger;
use App\Utils\Response;
use App\Models\Database;

$userId = (int) ($_SERVER['AUTH_USER_ID'] ?? 0);
if ($userId === 0) {
    Response::error('No autenticado', 401);
    exit;
}

// Verificar que el usuario es admin (role_id = 1) directamente en DB
$db     = new Database();
$rows   = $db->getDB('users', ['id' => $userId]);
$roleId = (int) ($rows[0]['role_id'] ?? 0);

if ($roleId !== 1) {
    Response::error('Acceso restringido a administradores', 403);
    exit;
}

switch ($_SERVER['REQUEST_METHOD']) {
    case 'GET':
        $limit = min((int) ($_GET['limit'] ?? 300), 1000);
        Response::ok(SecurityLogger::read($limit));
        break;

    case 'DELETE':
        SecurityLogger::clear();
        SecurityLogger::log('SECURITY_LOG_CLEARED', ['cleared_by_user_id' => $userId]);
        Response::ok();
        break;

    default:
        header('Allow: GET, DELETE');
        Response::error('Método no permitido', 405);
}
