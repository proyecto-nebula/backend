<?php
use PHPUnit\Framework\TestCase;

class JuegosFiltros extends TestCase {

    private $baseUrl = "http://localhost:3000/Nebula/api/v1/juegos";

    public function testPorDesarrollador() {
        $this->assertEndpoint("/id_desarrollador/1");
    }

    public function testPorPEGI() {
        $this->assertEndpoint("/id_pegi/1");
    }

    public function testPorSteam() {
        $this->assertEndpoint("/id_steam/1");
    }

    public function testPorIGDB() {
        $this->assertEndpoint("/id_igdb/1");
    }

    public function testPorTitulo() {
        $this->assertEndpoint("/titulo/The%20Witcher%203:%20Wild%20Hunt");
    }

    public function testPorMetacritic() {
        $this->assertEndpoint("/metacritic/93");
    }

    public function testMetacriticMax() {
        $this->assertEndpoint("/metacritic_max/93");
    }

    public function testMetacriticMin() {
        $this->assertEndpoint("/metacritic_min/93");
    }

    public function testDestacado() {
        $this->assertEndpoint("/destacado/1");
    }

    public function testFechaPublicacion() {
        $this->assertEndpoint("/fecha_publicacion/2015-05-19");
    }

    public function testFechaLanzamiento() {
        $this->assertEndpoint("/fecha_lanzamiento/2015-05-19");
    }

    public function testHero() {
        $this->assertEndpoint("/hero/1");
    }

    private function assertEndpoint($path) {
        $response = @file_get_contents($this->baseUrl . $path);

        $this->assertNotFalse($response, "Fallo en endpoint: $path");

        $data = json_decode($response, true);

        $this->assertIsArray($data);
    }

}
