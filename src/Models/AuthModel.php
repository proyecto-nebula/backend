<?php
namespace App\Models;
/**
 * Clase del modelo para la tabla de usuarios
 * Representa un registro de la tabla de usuarios y permite hacer el login, obtener un token de un usuario y actualizar el token de un usuario
 */
class AuthModel
{
    private $connection;
    private $host;
	private $db;
	private $user;
	private $password;
	private $port;
    
    public function __construct(){
        
        $this->host     = getenv('DB_HOST');
		$this->db       = getenv('DB_NAME');
		$this->user     = getenv('DB_USER');
		$this->password = getenv('DB_PASSWORD');
		$this->port     = getenv('DB_PORT');
        // Ajustado a los datos de tu SQL y servidor db
        //$this->connection = new \mysqli('db', 'root', 'root', 'Proyecto_Final', '3306');
        $this->connection = mysqli_init();
		$this->connection->options(MYSQLI_OPT_INT_AND_FLOAT_NATIVE, 1);
		$this->connection->real_connect(
			$this->host,
			$this->user,
			$this->password,
			$this->db,
			$this->port
		);

        if ($this->connection->connect_errno){
            echo 'Error de conexión a la base de datos';
            exit;
        }

    }

    /**
     * Método para autentificarse en la API
     * Corregido: nombre de tabla 'users' y columna 'email'
     */
    public function login($email, $password)
    {
        $stmt = $this->connection->prepare(
            'SELECT id, email FROM users WHERE email = ? AND password = ?'
        );
        $stmt->bind_param('ss', $email, $password);
        $stmt->execute();
        $result = $stmt->get_result();
        $resultArray = [];
        while ($row = $result->fetch_assoc()) {
            $resultArray[] = $row;
        }
        $stmt->close();
        return $resultArray;
    }

    /**
     * Método para actualizar el token de un usuario con un determinado id
     * Corregido: nombre de tabla 'users' e 'id'
     */
    public function update($id, $token)
    {
        $stmt = $this->connection->prepare(
            'UPDATE users SET token = ?, last_login_at = CURRENT_TIMESTAMP WHERE id = ?'
        );
        $stmt->bind_param('si', $token, $id);
        $stmt->execute();
        $affected = $this->connection->affected_rows;
        $stmt->close();
        return $affected > 0 ? $affected : 0;
    }

    /**
     * Método para obtener el token de un determinado id
     * Corregido: nombre de tabla 'users' e 'id'
     */
    public function getById($id)
    {
        $stmt = $this->connection->prepare(
            'SELECT token, last_login_at FROM users WHERE id = ?'
        );
        $stmt->bind_param('i', $id);
        $stmt->execute();
        $result = $stmt->get_result();
        $resultArray = [];
        while ($row = $result->fetch_assoc()) {
            $resultArray[] = $row;
        }
        $stmt->close();
        return $resultArray;
    }
}
