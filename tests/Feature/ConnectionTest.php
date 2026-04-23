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
        // Enviamos un POST con JSON según el contrato actual del endpoint.
        $response = $this->client->request('POST', '/api/v1/auth', [
            'json' => [
                'email' => 'admin@ejemplo.com',
                'password' => 'admin'
            ]
        ]);

        $status = $response->getStatusCode();

        $this->assertContains($status, [201, 403, 400], "El endpoint de Auth devolvió un estado inesperado: $status");

        if ($status === 201) {
            $payload = json_decode((string) $response->getBody(), true);
            $this->assertIsArray($payload);
            $this->assertArrayHasKey('token', $payload);
            $this->assertNotEmpty($payload['token']);
        }
    }

   /** @test */
    public function test_api_endpoints_health() {
        $endpoints = [
            'avatars', 'screenshots', 'categories', 'studios', 
            'favorites', 'games', 'game_categories', 
            'sessions', 'pegi', 'roles', 'plans', 'users'
        ];

        foreach ($endpoints as $resource) {
            $response = $this->client->get("/api/v1/$resource");
            $status = $response->getStatusCode();
            
            // En endpoints protegidos, sin token deben devolver 401.
            $this->assertContains($status, [200, 401], "Fallo en endpoint: /api/v1/$resource (Código: $status)");
        }
    }

    /** @test */
    public function test_auth_endpoint_exists() {
        // Auth permite solo POST; GET debe responder método no permitido.
        $response = $this->client->get("/api/v1/auth");
        $this->assertEquals(405, $response->getStatusCode(), "El endpoint de Auth debería responder 405 en GET.");
    }
}
