<?php
use PHPUnit\Framework\TestCase;

class ConnectionTest extends TestCase {

    /** @test */
    public function test_db_connection() {
    // Forzamos la lectura de las variables configuradas en el YAML
    $host = 'db';
    $user = getenv('DB_USER') ?: 'root'; 
    $pass = getenv('DB_PASSWORD') ?: 'root';
    $db   = getenv('DB_NAME') ?: 'Nebula_db';

    $mysqli = new mysqli($host, $user, $pass, $db);
    $this->assertNull($mysqli->connect_error, "Fallo: " . $mysqli->connect_error);
    $mysqli->close();
}

   /** @test */
public function test_api_endpoints_are_up() {
    $client = new \GuzzleHttp\Client(['base_uri' => 'http://127.0.0.1:8000']);
    
    // IMPORTANTE: La ruta debe empezar con /api/v1/ seguido de un recurso real
    // Ejemplo: /api/v1/juegos o /api/v1/usuarios
    $response = $client->request('GET', '/api/v1/juegos'); 

    $this->assertEquals(200, $response->getStatusCode(), "El recurso juegos no respondió correctamente.");
}
}
