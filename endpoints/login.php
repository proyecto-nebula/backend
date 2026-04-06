<?php
require_once __DIR__ . '/../src/auth.model.php'; // Asegúrate de que la ruta sea correcta
require_once __DIR__ . '/../src/response.php';

// Permitir peticiones desde cualquier origen y formato JSON
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");

// Solo aceptamos peticiones POST
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    
    // Leemos el cuerpo de la petición (JSON)
    $json = file_get_contents('php://input');
    $datos = json_decode($json, true);

    $auth = new Authentication();
    
    // El método signIn devuelve el JWT si todo es correcto
    $jwt = $auth->signIn($datos);

    if ($jwt) {
        $response = [
            "result" => "ok",
            "token" => $jwt
        ];
        Response::result(200, $response);
    }
} else {
    $response = [
        "result" => "error",
        "details" => "Método no permitido"
    ];
    Response::result(405, $response);
}