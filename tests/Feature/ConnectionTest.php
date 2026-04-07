<?php
use PHPUnit\Framework\TestCase;

class ConnectionTest extends TestCase {

    /** @test */
    public function test_db_connection() {
    // Forzamos la lectura de las variables configuradas en el YAML
    $host = '127.0.0.1';
    $user = getenv('DB_USER') ?: 'root'; 
    $pass = getenv('DB_PASSWORD') ?: 'root';
    $db   = getenv('DB_NAME') ?: 'Nebula_db';

    $mysqli = new mysqli($host, $user, $pass, $db);
    $this->assertNull($mysqli->connect_error, "Fallo: " . $mysqli->connect_error);
    $mysqli->close();
}

   /** @test */
/** @test */
public function test_api_endpoints_are_up() {
    $client = new \GuzzleHttp\Client(['base_uri' => 'http://127.0.0.1:8000']);
    
    // Probamos el endpoint de status que no depende de la DB ni de clases externas
    $response = $client->request('GET', '/api/v1/status'); 

    $this->assertEquals(200, $response->getStatusCode(), "El servidor respondió con error 500. Revisa los logs de PHP.");
}
}
