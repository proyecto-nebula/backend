<?php
use PHPUnit\Framework\TestCase;

class GameTest extends TestCase {

    private $baseUrl = "http://localhost:8000/api/v1/1";

    public function testObtenerTodosLosJuegos() {
        $response = @file_get_contents($this->baseUrl . "/juegos");

        $this->assertNotFalse($response);

        $data = json_decode($response, true);

        $this->assertIsArray($data);
    }

    public function testJuegoPorId() {
        $response = @file_get_contents($this->baseUrl . "/juegos/id_juego/1");

        $this->assertNotFalse($response);

        $data = json_decode($response, true);

        $this->assertIsArray($data);
    }

}
