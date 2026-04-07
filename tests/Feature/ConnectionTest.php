<?php
use PHPUnit\Framework\TestCase;
use GuzzleHttp\Client;

class ConnectionTest extends TestCase {
    private $client;

    protected function setUp(): void {
        $this->client = new Client([
            'base_uri' => 'http://127.0.0.1:8000',
            'http_errors' => false, // IMPORTANTE: Esto evita que el test se detenga si hay un error 500
            'timeout' => 10
        ]);
    }

    /** @test */
    public function test_api_endpoints_health() {
        $endpoints = [
            'avatares', 'capturas', 'categorias', 'estudios', 
            'favoritos', 'juegos', 'juegos_categorias', 
            'partidas', 'pegi', 'roles', 'suscripcion', 'test', 'usuarios'
        ];

        foreach ($endpoints as $resource) {
            $response = $this->client->get("/api/v1/$resource");
            $status = $response->getStatusCode();
            
            $this->assertEquals(200, $status, "Fallo en endpoint: /api/v1/$resource (Código: $status)");
        }
    }

    /** @test */
    public function test_auth_endpoint_exists() {
        // Auth suele dar error si no envías POST, así que solo chequeamos que el archivo existe (no da 404)
        $response = $this->client->get("/api/v1/auth");
        $this->assertNotEquals(404, $response->getStatusCode(), "El endpoint de Auth no existe o el router falla.");
    }
}
