<?php

require_once __DIR__ . '/../src/core/router.php';

// CORS
$frontendUrl = $_ENV['FRONTEND_URL'] ?? 'http://localhost:4200';
header("Access-Control-Allow-Origin: $frontendUrl");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, api-key, Authorization");
header("Access-Control-Allow-Credentials: true");
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') { exit; } // Responder a preflight requests
// Ejecutar Router
Router::dispatch(parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH));