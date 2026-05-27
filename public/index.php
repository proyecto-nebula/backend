<?php
require_once __DIR__ . '/../vendor/autoload.php';
require_once __DIR__ . '/../bootstrap.php';

use App\Core\Router;

// --- Manejo seguro de errores en producción ---
if (getenv('APP_ENV') === 'production') {
    ini_set('display_errors', '0');
    error_reporting(0);
    set_exception_handler(function (\Throwable $e) {
        http_response_code(500);
        header('Content-Type: application/json; charset=utf-8');
        echo json_encode(['error' => 'Ha ocurrido un error interno en el servidor. Por favor, inténtelo más tarde.']);
        exit;
    });
}

// --- CORS: whitelist explícita de orígenes ---
$rawAllowed = getenv('ALLOWED_ORIGINS') ?: '';
$allowedOrigins = array_filter(array_map('trim', explode(',', $rawAllowed)));
$origin = $_SERVER['HTTP_ORIGIN'] ?? '';

if ($origin !== '' && in_array($origin, $allowedOrigins, true)) {
    header("Access-Control-Allow-Origin: $origin");
    header("Access-Control-Allow-Credentials: true");
    header("Vary: Origin");
}

header("Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, PATCH, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With");

// Responder inmediatamente al Preflight de CORS
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    header("HTTP/1.1 204 No Content");
    exit;
}

// --- Cabeceras de seguridad HTTP ---
header("X-Content-Type-Options: nosniff");
header("X-Frame-Options: DENY");
header("Referrer-Policy: no-referrer-when-downgrade");
header("Permissions-Policy: geolocation=(), camera=(), microphone=()");
if (getenv('APP_ENV') === 'production') {
    header("Strict-Transport-Security: max-age=31536000; includeSubDomains");
}

$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
Router::dispatch($uri);