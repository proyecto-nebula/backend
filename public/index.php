<?php

require_once __DIR__ . '/../vendor/autoload.php';
require_once __DIR__ . '/../bootstrap.php';

use App\Core\Router;

// CORS
$frontendUrl = $_ENV['FRONTEND_URL'] ?? 'http://localhost:4200';

header("Access-Control-Allow-Origin: $frontendUrl");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Access-Control-Allow-Credentials: true");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

// Router (SIN INSTANCIAR)
Router::dispatch($_SERVER['REQUEST_URI']);
