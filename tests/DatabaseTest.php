<?php
use PHPUnit\Framework\TestCase;

class DatabaseTest extends TestCase {
    public function test_conexion_base_de_datos() {
        // Obtenemos los datos del .env que generamos en el YAML
        $host = getenv('DB_HOST');
        $db   = getenv('DB_NAME');
        $user = getenv('DB_USER');
        $pass = getenv('DB_PASSWORD');

        $conexion = new mysqli($host, $user, $pass, $db);

        // Si la conexión falla, el test falla
        $this->assertFalse($conexion->connect_error, "Error de conexión: " . $conexion->connect_error);
        
        echo "\nConexión exitosa a la base de datos de Nebula!";
    }
}
