<?php

use PHPUnit\Framework\TestCase;
use GuzzleHttp\Client;

class ConnectionTest extends TestCase
{
    private Client $client;

    protected function setUp(): void
    {
        $this->client = new Client([
            'base_uri' => 'http://localhost:8000',
            'http_errors' => false
        ]);
    }

    public function test_api_connection(): void
    {
        $response = $this->client->request('GET', '/');

        $this->assertEquals(200, $response->getStatusCode());
    }

    public function test_auth_endpoint_response(): void
    {
        $response = $this->client->request('POST', '/api/v1/auth', [
            'json' => [
                'email' => 'admin@ejemplo.com',
                'password' => 'admin'
            ]
        ]);

        $status = $response->getStatusCode();

        $this->assertContains(
            $status,
            [200, 201, 400, 401, 403],
            "El endpoint de Auth devolvió un estado inesperado: $status"
        );

        // Solo validar token si login correcto
        if ($status === 200 || $status === 201) {

            $body = (string) $response->getBody();

            $this->assertNotEmpty(
                $body,
                'El body de la respuesta está vacío.'
            );

            $payload = json_decode($body, true);

            $this->assertNotNull(
                $payload,
                'La respuesta no contiene JSON válido.'
            );

            $this->assertIsArray($payload);

            $this->assertArrayHasKey('token', $payload);

            $this->assertNotEmpty($payload['token']);
        }
    }

    public function test_api_endpoints_health(): void
    {
        $endpoints = [
            'avatars',
            'screenshots',
            'categories',
            'studios',
            'favorites',
            'games',
            'game_categories',
            'sessions',
            'pegi',
            'roles',
            'plans',
            'users'
        ];

        foreach ($endpoints as $resource) {

            $response = $this->client->request(
                'GET',
                "/api/v1/$resource"
            );

            $status = $response->getStatusCode();

            // Endpoints protegidos pueden devolver 401
            $this->assertContains(
                $status,
                [200, 401],
                "Fallo en endpoint: /api/v1/$resource (Código: $status)"
            );
        }
    }

    public function test_auth_endpoint_exists(): void
    {
        // Auth debe permitir solo POST
        $response = $this->client->request(
            'GET',
            '/api/v1/auth'
        );

        $this->assertEquals(
            405,
            $response->getStatusCode(),
            'El endpoint de Auth debería responder 405 en GET.'
        );
    }
}
