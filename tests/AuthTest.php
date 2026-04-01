<?php
use PHPUnit\Framework\TestCase;

class AuthTest extends TestCase {

    private $baseUrl = "http://localhost:3000";

    public function testAuthEndpointResponde() {
        $url = $this->baseUrl . "/nebula/apirestitems/auth.php";

        $response = @file_get_contents($url);

        $this->assertNotFalse($response, "El endpoint auth no responde");

        $data = json_decode($response, true);

        $this->assertIsArray($data);
    }

}
