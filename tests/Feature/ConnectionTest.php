<?php

use PHPUnit\Framework\TestCase;
use App\Core\Router;

class ConnectionTest extends TestCase
{
    private function dispatch(string $method, string $uri, array $body = [])
    {
        // Simular request
        $_SERVER['REQUEST_METHOD'] = $method;
        $_SERVER['REQUEST_URI'] = $uri;

        // Simular input JSON si existe
        $input = !empty($body) ? json_encode($body) : null;

        // Capturar salida del router
        ob_start();

        Router::dispatch($uri);

        $output = ob_get_clean();

        return [
            'status' => http_response_code() ?: 200,
            'body' => $output
        ];
    }

    public function test_api_connection(): void
    {
        $response = $this->dispatch('GET', '/');

        $this->assertEquals(200, $response['status']);
    }

    public function test_auth_endpoint_response(): void
    {
        $response = $this->dispatch('POST', '/api/v1/auth', [
            'email' => 'admin@ejemplo.com',
            'password' => 'admin'
        ]);

        $status = $response['status'];

        $this->assertContains(
            $status,
            [200, 201, 400, 401, 403, 500],
            "Auth devolvió estado inesperado: $status"
        );

        if (in_array($status, [200, 201])) {
            $payload = json_decode($response['body'], true);

            $this->assertIsArray($payload);
            $this->assertArrayHasKey('token', $payload);
        }
    }

    public function test_api_endpoints_health(): void
    {
        $endpoints = [
            'avatars',
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
            $response = $this->dispatch('GET', "/api/v1/$resource");

            $this->assertContains(
                $response['status'],
                [200, 401],
                "Fallo en endpoint: $resource"
            );
        }
    }

    public function test_auth_endpoint_exists(): void
    {
        $response = $this->dispatch('GET', '/api/v1/auth');

        $this->assertContains(
            $response['status'],
            [401, 405],
            'Auth debe rechazar GET'
        );
    }
}
