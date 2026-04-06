<?php
// 1. Obtener la ruta limpia
$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

// 2. Buscar la posición de /api/v1/ para ser más flexibles
$apiPrefix = '/api/v1/';
$pos = strpos($uri, $apiPrefix);

if ($pos === false) {
    http_response_code(404);
    echo json_encode(['error' => 'Prefijo api/v1 no encontrado']);
    exit;
}

// 3. Extraer lo que viene después de /api/v1/
// Ejemplo: "usuarios/5" o "usuarios"
$route = substr($uri, $pos + strlen($apiPrefix));
$parts = explode('/', trim($route, '/'));

$resource = $parts[0] ?? null; // usuarios, juegos...
$id = $parts[1] ?? null;       // 5 (opcional)

// 4. Inyectar el ID en $_GET para que tus archivos actuales lo lean
if ($id) {
    if ($resource === 'usuarios') $_GET['id_usuario'] = $id;
    if ($resource === 'juegos')   $_GET['id_juego'] = $id;
    // Añade aquí otros si tienes más recursos (ej: 'roles' => 'id_rol')
}

// 5. Cargar el archivo original desde la carpeta endpoints
$projectRoot = dirname(__DIR__); // Esto sube de 'public' a la raíz del proyecto
$file = $projectRoot . "/endpoints/$resource.php";

if ($resource && file_exists($file)) {
    require_once $file;
} else {
    http_response_code(404);
    echo json_encode([
        'error' => 'Recurso no encontrado',
        'debug' => [
            'resource_buscado' => $resource,
            'ruta_fich' => $file
        ]
    ]);
}