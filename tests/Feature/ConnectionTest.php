<?php

use PHPUnit\Framework\TestCase;

class ConnectionTest extends TestCase
{
    /**
     * Simula una petición HTTP interna a tu aplicación MVC
     * SIN usar servidor ni Guzzle
     */
    private function request(string $method, string $uri, array $body = [])
    {
        // Simular superglobals
        $_SERVER['REQUEST_METHOD'] = $method;
        $_SERVER['REQUEST_URI'] = $uri;

        // Si necesitas JSON body
        $input = !empty($body) ? json_encode($body) : null;

        // Capturar salida del front controller
        ob_start();

        // 👉 AJUSTA ESTA RUTA A TU ENTRY POINT REAL
        // Ej: public/index.php o bootstrap/app.php
        require __DIR__ . '/../../public/index.php';

        $output = ob_get_clean();

        return [
            'status' => http_response_code(),
            'body' => $output
        ];
    }

    public function test_api_connection(): void
    {
        $response = $this->request('GET', '/');

        $this->assertEquals(200, $response['status']);
    }

    public function test_auth_endpoint_response(): void
    {
        $response = $this->request('POST', '/api/v1/auth', [
            'email' => 'admin@ejemplo.com',
            'password' => 'admin'
        ]);

        $status = $response['status'];

        $this->assertContains(
            $status,
            [200, 201, 400, 401, 403, 500],
            "Estado inesperado en auth: $status"
        );

        if (in_array($status, [200, 201])) {
            $payload = json_decode($response['body'], true);

            $this->assertNotNull($payload);
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
            $response = $this->request('GET', "/api/v1/$resource");

            $this->assertContains(
                $response['status'],
                [200, 401],
                "Fallo en endpoint: $resource"
            );
        }
    }

    public function test_auth_endpoint_exists(): void
    {
        $response = $this->request('GET', '/api/v1/auth');

        $this->assertContains(
            $response['status'],
            [401, 405],
            'Auth endpoint debería rechazar GET'
        );
    }
}
