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
		$this->host     = getenv('DB_HOST') ?: '127.0.0.1';
		$this->db       = getenv('DB_NAME') ?: '';
		$this->user     = getenv('DB_USER') ?: 'root';
		$this->password = getenv('DB_PASSWORD') ?: '';
		$this->port     = getenv('DB_PORT') ?: 3306;

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

		if ($this->connection->connect_errno) {
    throw new \Exception(
        'DB connection failed: ' . $this->connection->connect_error
    );
}

	}

	/**
	 * Método para recuperar datos de una tabla, pudiendo indicar filtros con el parámetro $extra
	 */
	public function getDB($table, $extra = null)
	{
		$page = 0;
		$safeTable = str_replace('`', '', $table);
		$query = "SELECT * FROM `$safeTable`";
		$types = '';
		$bindings = [];

		if (isset($extra['page'])) {
			$page = (int) $extra['page'];
			unset($extra['page']);
		}

		if (!empty($extra)) {
			$conditions = [];
			foreach ($extra as $key => $condition) {
				$safeKey = str_replace('`', '', $key);
				$conditions[] = "`$safeKey` = ?";
				$types .= 's';
				$bindings[] = $condition;
			}
			$query .= ' WHERE ' . implode(' AND ', $conditions);
		}

		/**
		 * Aquí se paginan los resultados para evitar recuperar todos los registros de una tabla que contenga muchísimos
		 */
		$since = $page > 0 ? ($page - 1) * $this->results_page : 0;
		$query .= ' LIMIT ?, ?';
		$types .= 'ii';
		$bindings[] = $since;
		$bindings[] = $this->results_page;

		$stmt = $this->connection->prepare($query);
		if (!$stmt) {
			throw new \Exception('Error en prepare: ' . $this->connection->error);
		}
		$stmt->bind_param($types, ...$bindings);
		$stmt->execute();
		$results = $stmt->get_result();
		$stmt->close();

		$resultArray = [];
		foreach ($results as $value) {
			$resultArray[] = $value;
		}
		return $resultArray;
	}

	/**
	 * Método para recuperar TODOS los datos sin límite de paginación
	 */
	public function getAllDB($table, $extra = null)
	{
		$safeTable = str_replace('`', '', $table);
		$query = "SELECT * FROM `$safeTable`";
		$types = '';
		$bindings = [];

		if (!empty($extra)) {
			$conditions = [];
			foreach ($extra as $key => $condition) {
				$safeKey = str_replace('`', '', $key);
				$conditions[] = "`$safeKey` = ?";
				$types .= 's';
				$bindings[] = $condition;
			}
			$query .= ' WHERE ' . implode(' AND ', $conditions);
		}

		if (!empty($bindings)) {
			$stmt = $this->connection->prepare($query);
			if (!$stmt) {
				throw new \Exception('Error en prepare: ' . $this->connection->error);
			}
			$stmt->bind_param($types, ...$bindings);
			$stmt->execute();
			$results = $stmt->get_result();
			$stmt->close();
		} else {
			$results = $this->connection->query($query);
		}

		$resultArray = [];
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
		$fields = array_keys($data);
		$placeholders = implode(',', array_fill(0, count($fields), '?'));
		$types = '';
		$values = [];
		foreach ($fields as $field) {
			$value = $data[$field];
			// Determinar el tipo para bind_param
			if (is_int($value)) {
				$types .= 'i';
			} elseif (is_float($value)) {
				$types .= 'd';
			} else {
				$types .= 's';
			}
			$values[] = $value;
		}
		$fields_sql = implode(',', $fields);
		$query = "INSERT INTO $table ($fields_sql) VALUES ($placeholders)";
		$stmt = $this->connection->prepare($query);
		if (!$stmt) {
			throw new \Exception('Error en prepare: ' . $this->connection->error);
		}
		$stmt->bind_param($types, ...$values);
		$stmt->execute();
		$insert_id = $stmt->insert_id;
		$stmt->close();
		return $insert_id;
	}

	/**
	 * Método para actualizar un registro de la BD
	 * Hay que indicar el registro mediante un campo que sea clave primaria y que debe llamarse "id"
	 * El parámetro "pk" indica la columna de la tabla que es primary key
	 */
	public function updateDB($table, $id, $pk, $data)
	{
		$conn = $this->connection;
		$setParts = [];
		foreach ($data as $key => $value) {
			if (is_null($value)) {
				$setParts[] = "`$key` = NULL";
			} else {
				$escaped = $conn->real_escape_string((string) $value);
				$setParts[] = "`$key` = '$escaped'";
			}
		}

		if (empty($setParts)) return 0;

		$query = 'UPDATE `' . $table . '` SET ' . implode(', ', $setParts) . ' WHERE `' . $pk . '` = ' . (int) $id;

		$result = $conn->query($query);

		if ($result === false) {
			error_log('[updateDB] Error: ' . $conn->error . ' | Query: ' . $query);
			return -1;
		}

		return $conn->affected_rows; // 0 = no rows changed, ≥1 = updated
	}

	/**
	 * Método para eliminar un registro de la BD
	 * Hay que indicar el registro mediante un campo que sea clave primaria y que debe llamarse "id"
	 * El parámetro "pk" indica la columna de la tabla que es primary key
	 */
	public function deleteDB($table, $id, $pk)
	{
		$safeTable = str_replace('`', '', $table);
		$safePk    = str_replace('`', '', $pk);
		$query = "DELETE FROM `$safeTable` WHERE `$safePk` = ?";
		$stmt = $this->connection->prepare($query);
		if (!$stmt) {
			throw new \Exception('Error en prepare: ' . $this->connection->error);
		}
		$stmt->bind_param('i', $id);
		$stmt->execute();
		$affected = $stmt->affected_rows;
		$stmt->close();

		return $affected > 0 ? $affected : 0;
	}

	public function getConnection() {
        return $this->connection;
    }
}


?>
