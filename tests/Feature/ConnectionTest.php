<?php
use PHPUnit\Framework\TestCase;

class ConnectionTest extends TestCase {

    /** @test */
    public function test_db_connection() {
        // Leemos las variables que el YAML inyectó en el .env
        $host = getenv('DB_HOST') ?: '127.0.0.1';
        $user = getenv('DB_USER');
        $pass = getenv('DB_PASSWORD');
        $db   = getenv('DB_NAME');

        $mysqli = new mysqli($host, $user, $pass, $db);

        $this->assertNull($mysqli->connect_error, "Fallo total: No se pudo conectar a la DB de Nebula.");
        $mysqli->close();
    }

    /** @test */
    public function test_api_endpoints_are_up() {
        $client = new \GuzzleHttp\Client(['base_uri' => 'http://127.0.0.1:8000']);
        
        // Aquí puedes añadir todos los endpoints que tus compañeros vayan creando
        $endpoints = ['/', '/api/status']; 

        foreach ($endpoints as $url) {
            try {
                $response = $client->request('GET', $url);
                $this->assertEquals(200, $response->getStatusCode(), "El endpoint $url está caído.");
            } catch (\Exception $e) {
                // Si el endpoint no existe todavía, lo marcamos como advertencia o fallo
                $this->fail("Error al conectar con el endpoint $url: " . $e->getMessage());
            }
        }
    }
}
