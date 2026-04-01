<?php
use PHPUnit\Framework\TestCase;

class ErrorTest extends TestCase {

    private $baseUrl = "http://localhost:3000/Nebula/api/v1/juegos";

    public function testJuegoNoExiste() {
        $response = @file_get_contents($this->baseUrl . "/id_juego/999999");

        // Puede devolver null o array vacío
        $this->assertNotFalse($response);

        $data = json_decode($response, true);

        $this->assertTrue(
            empty($data) || isset($data['error']),
            "Debería devolver error o vacío"
        );
    }

}
