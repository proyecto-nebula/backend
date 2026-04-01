<?php
use PHPUnit\Framework\TestCase;

class SubscriptionTest extends TestCase {

    private $baseUrl = "http://localhost:3000/Nebula/api/v1/suscripcion";

    public function testTodasLasSuscripciones() {
        $this->assertEndpoint("");
    }

    public function testSuscripcionPorId() {
        $this->assertEndpoint("/id_suscripcion/1");
    }

    public function testPorNombre() {
        $this->assertEndpoint("/nombre/Gratis");
    }

    public function testPrecioMin() {
        $this->assertEndpoint("/precio_min/5");
    }

    private function assertEndpoint($path) {
        $response = @file_get_contents($this->baseUrl . $path);

        $this->assertNotFalse($response);

        $data = json_decode($response, true);

        $this->assertIsArray($data);
    }

}
