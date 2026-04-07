<?php
use PHPUnit\Framework\TestCase;
use GuzzleHttp\Client;

class ConnectionTest extends TestCase {
    private $client;

    protected function setUp(): void {
        // Configuramos el cliente para conectar con el servidor de GitHub Actions
        $this->client = new Client([
            'base_uri' => 'http://127.0.0.1:8000',
            'http_errors' => false, // Evita que PHPUnit se detenga bruscamente con errores 404 o 500
            'timeout' => 5
        ]);
    }

    /** @test */
    public function test_db_connection() {
        // Prueba básica de conexión a la base de datos
        $host = '127.0.0.1';
        $user = getenv('DB_USER') ?: 'root';
        $pass = getenv('DB_PASSWORD') ?: 'root';
        $db   = getenv('DB_NAME') ?: 'nebula_db';

        $mysqli = new mysqli($host, $user, $pass, $db);
        $this->assertNull($mysqli->connect_error, "Error conectando a la DB: " . $mysqli->connect_error);
        $mysqli->close();
    }

    /** @test */
    public function test_all_api_endpoints() {
        // Lista completa basada en tus archivos reales
        $endpoints = [
            'auth', 'avatares', 'capturas', 'categorias', 'estudios', 
            'favoritos', 'juegos', 'juegos_categorias', 'login', 
            'partidas', 'pegi', 'roles', 'suscripcion', 'test', 'usuarios'
        ];

        foreach ($endpoints as $resource) {
            $url = "/api/v1/$resource";
           $response = $this->client->request('GET', $url);

            // Verificamos que el archivo existe (no debe dar 404)
            $this->assertNotEquals(404, $response->getStatusCode(), "El archivo para $url no existe.");
            
            // Solo pedimos JSON si NO es el endpoint de auth (mientras lo arregláis)
            if ($resource !== 'auth' && $resource !== 'login') {
                $contentType = $response->getHeaderLine('Content-Type');
                $this->assertStringContainsString('application/json', $contentType);
            }
            
            // Verificamos que el servidor responda 200 OK
            $this->assertEquals(
                200, 
                $response->getStatusCode(), 
                "El endpoint [$url] ha fallado con código " . $response->getStatusCode()
            );

            // Verificamos que devuelva un JSON (opcional pero recomendado)
            $contentType = $response->getHeaderLine('Content-Type');
            $this->assertStringContainsString('application/json', $contentType, "El endpoint [$url] no devolvió JSON.");
        }
    }
}
