<?php
namespace App\Models;
/**
 * Clase con la lógica para conectarse a la base de datos. 
 */
class Database
{
	private $connection;
	private $results_page = 50;

	private $host;
	private $db;
	private $user;
	private $password;
	private $port;

	public function __construct()
	{
		$this->host     = getenv('DB_HOST');
		$this->db       = getenv('DB_NAME');
		$this->user     = getenv('DB_USER');
		$this->password = getenv('DB_PASSWORD');
		$this->port     = getenv('DB_PORT');

		//$this->connection = new \mysqli('db', 'root', 'root', 'Proyecto_Final', '3306');
		$this->connection = new \mysqli(
			$this->host,
			$this->user,
			$this->password,
			$this->db,
			$this->port
		);

		if ($this->connection->connect_errno) {
			echo 'Error de conexión a la base de datos';
			exit;
		}

		$this->connection->set_charset('utf8mb4');
	}

	/**
	 * Método para recuperar datos de una tabla, pudiendo indicar filtros con el parámetro $extra
	 */
	public function getDB($table, $extra = null)
	{
		$page = 0;
		$query = "SELECT * FROM $table";

		if (isset($extra['page'])) {
			$page = $extra['page'];
			unset($extra['page']);
		}

		if ($extra != null) {
			$query .= ' WHERE';

			foreach ($extra as $key => $condition) {
				$query .= ' ' . $key . ' = "' . $condition . '"';
				if ($extra[$key] != end($extra)) {
					$query .= " AND ";
				}
			}
		}

		/**
		 * Aquí se paginan los resultados para evitar recuperar todos los registros de una tabla que contenga muchísimos
		 */
		if ($page > 0) {
			$since = (($page - 1) * $this->results_page);
			$query .= " LIMIT $since, $this->results_page";
		} else {
			$query .= " LIMIT 0, $this->results_page";
		}

		$results = $this->connection->query($query);
		$resultArray = array();

		foreach ($results as $value) {
			$resultArray[] = $value;
		}

		return $resultArray;
	}

	/**
	 * Método para insertar un nuevo registro
	 */
	public function insertDB($table, $data)
	{
		$fields = implode(',', array_keys($data));
		$values = '"';
		$values .= implode('","', array_values($data));
		$values .= '"';

		$query = "INSERT INTO $table (" . $fields . ') VALUES (' . $values . ')';
		$this->connection->query($query);

		return $this->connection->insert_id;
	}

	/**
	 * Método para actualizar un registro de la BD
	 * Hay que indicar el registro mediante un campo que sea clave primaria y que debe llamarse "id"
	 * El parámetro "pk" indica la columna de la tabla que es primary key
	 */
	public function updateDB($table, $id, $pk, $data)
	{
		$query = "UPDATE $table SET ";
		foreach ($data as $key => $value) {
			$query .= "$key = '$value'";
			if (sizeof($data) > 1 && $key != array_key_last($data)) {
				$query .= " , ";
			}
		}

		$query .= ' WHERE ' . $pk . ' = ' . $id;

		$this->connection->query($query);

		if (!$this->connection->affected_rows) {
			return 0;
		}

		return $this->connection->affected_rows;
	}

	/**
	 * Método para eliminar un registro de la BD
	 * Hay que indicar el registro mediante un campo que sea clave primaria y que debe llamarse "id"
	 * El parámetro "pk" indica la columna de la tabla que es primary key
	 */
	public function deleteDB($table, $id, $pk)
	{
		$query = "DELETE FROM $table WHERE $pk = $id";
		$this->connection->query($query);

		if (!$this->connection->affected_rows) {
			return 0;
		}

		return $this->connection->affected_rows;
	}

	public function getConnection() {
        return $this->connection;
    }
}


?>