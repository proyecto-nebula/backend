<?php
/**
 * Clase del modelo para la tabla de usuarios
 * Representa un registro de la tabla de usuarios y permite hacer el login, obtener un token de un usuario y actualizar el token de un usuario
 */
class AuthModel
{
    private $connection;
    
    public function __construct(){
        // Ajustado a los datos de tu SQL y servidor db
        $this->connection = new mysqli('db', 'root', 'root', 'Proyecto_Final', '3306');

        if($this->connection->connect_errno){
            echo 'Error de conexión a la base de datos';
            exit;
        }
    }

    /**
     * Método para autentificarse en la API
     * Corregido: nombre de tabla 'USUARIOS' y columna 'nombre'
     */
    public function login($usuario, $password)
    {
       
        // En tu SQL la tabla es USUARIOS y la columna es nombre (no nombres)
        $query = "SELECT id_usuario, nombre FROM USUARIOS WHERE usuario = '$usuario' AND password = '$password'";

        $results = $this->connection->query($query);

        $resultArray = array();

        if($results != false){
            foreach ($results as $value) {
                $resultArray[] = $value;
            }
        }

        return $resultArray;
    }

    /**
     * Método para actualizar el token de un usuario con un determinado id
     * Corregido: nombre de tabla 'USUARIOS' e 'id_usuario'
     */
    public function update($id, $token)
    {
        // Corregido: id_usuario y USUARIOS
        $query = "UPDATE USUARIOS SET token = '$token' WHERE id_usuario = $id";

        $this->connection->query($query);
        
        if($this->connection->affected_rows <= 0){
            return 0;
        }

        return $this->connection->affected_rows;
    }

    /**
     * Método para obtener el token de un determinado id
     * Corregido: nombre de tabla 'USUARIOS' e 'id_usuario'
     */
    public function getById($id)
    {
        // Corregido: id_usuario y tabla USUARIOS
        $query = "SELECT token FROM USUARIOS WHERE id_usuario = $id";

        $results = $this->connection->query($query);

        $resultArray = array();

        if($results != false){
            foreach ($results as $value) {
                $resultArray[] = $value;
            }
        }

        return $resultArray;
    }
}