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
    public function test_auth_endpoint_response() {
        $client = new \GuzzleHttp\Client([
            'base_uri' => 'http://127.0.0.1:8000',
            'http_errors' => false // Evita que el test explote si devuelve 401 o 500
        ]);

        // Enviamos un POST simulando un intento de login
        $response = $client->request('POST', '/api/v1/auth', [
            'form_params' => [
                'alias' => 'admin',
                'password' => 'admin123'
            ]
        ]);

        $status = $response->getStatusCode();

        // Consideramos "éxito" si el servidor responde algo coherente:
        // 200 (Login OK), 401 (No autorizado), o 400 (Faltan datos)
        // Lo que NO queremos es un 500 (Error de código) o 404 (No encontrado)
        $this->assertContains($status, [200, 401, 400], "El endpoint de Auth devolvió un error crítico: $status");
    }

    /** @test */
    public function test_api_endpoints_health() {
        $endpoints = [
            'avatares', 'capturas', 'estudios', 
            'favoritos', 'juegos', 'juegos_categorias', 
            'partidas', 'pegi', 'roles', 'suscripciones', 'test', 'usuarios'
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
