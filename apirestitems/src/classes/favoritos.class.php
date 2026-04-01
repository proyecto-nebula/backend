<?php
/**
 * Clase para el modelo que representa a la tabla "FAVORITOS".
 */
require_once 'src/response.php';
require_once 'src/database.php';

class favoritos extends Database {
    /**
     * Atributo que indica la tabla asociada a la clase del modelo
     */
    private $table = 'FAVORITOS';

    /**
     * Atributo que indica la columna que es primary key en la tabla
     */
    private $primary_key = 'id_usuario'; // Referencia principal

    /**
     * Array con los campos de la tabla que se pueden usar como filtro para recuperar registros
     */
    private $allowedConditions_get = array(
        'id_usuario', 
        'id_juego', 
        'page'
    );

    /**
     * Array con los campos de la tabla que se pueden proporcionar para insertar registros
     */
    private $allowedConditions_insert = array(
        'id_usuario', 
        'id_juego'
    );

    /**
     * Método privado para filtrar los parámetros recibidos y evitar errores con las rutas del .htaccess
     */
    private function filtrarParametros($params, $allowed) {
        foreach ($params as $key => $value) {
            // Ignoramos 'url' y cualquier parámetro que empiece por 'id'
            if ($key === 'url' || strpos($key, 'id') === 0) continue;

            if (!in_array($key, $allowed)) {
                Response::result(400, array(
                    'result' => 'error', 
                    'details' => "El campo '$key' no es válido para esta consulta"
                ));
                exit;
            }
        }
    }

    /**
     * Método para validar los datos que se mandan para insertar un registro
     */
    private function validate($data) {
        if (!isset($data['id_usuario']) || empty($data['id_usuario']) || !isset($data['id_juego']) || empty($data['id_juego'])) {
            Response::result(400, array(
                'result' => 'error', 
                'details' => 'id_usuario e id_juego son obligatorios'
            ));
            exit;
        }
        return true;
    }

    /**
     * Método para recuperar registros, pudiendo indicar algunos filtros 
     */
    public function get($params) {
        // Limpiamos los parámetros para soportar rutas como /id_usuario/1
        $this->filtrarParametros($params, $this->allowedConditions_get);

        $items = parent::getDB($this->table, $params);

        return $items;
    }

    /**
     * Método para guardar un registro en la base de datos
     */
    public function insert($params) {
        $this->filtrarParametros($params, $this->allowedConditions_insert);

        if ($this->validate($params)) {
            return parent::insertDB($this->table, $params);
        }
    }

    /**
     * Método para borrar una relación específica de favoritos
     */
    public function delete($id) {
		$affected_rows = parent::deleteDB($this->table, $id, $this->primary_key);

		if ($affected_rows == 0) {
			$response = array(
				'result' => 'error',
				'details' => 'No hubo cambios'
			);

			Response::result(200, $response);
			exit;
		}
	}
}
?>