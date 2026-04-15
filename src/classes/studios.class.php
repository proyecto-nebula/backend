<?php
/**
 * Clase para el modelo que representa a la tabla "ESTUDIOS".
 */
require_once __DIR__ . '/../utils/response.php';
require_once __DIR__ . '/../models/database.php';

class estudios extends Database {
    /**
     * Atributo que indica la tabla asociada a la clase del modelo
     */
    private $table = 'estudios';

    /**
     * Atributo que indica la columna que es primary key en la tabla
     */
    private $primary_key = 'id_estudio';


    /**
     * Array con los campos de la tabla que se pueden usar como filtro para recuperar registros
     */
    private $allowedConditions_get = array(
        'id_estudio',
    );

    /**
     * Array con los campos de la tabla que se pueden proporcionar para insertar registros
     */
    private $allowedConditions_insert = array(
        'nombre_estudio',
        'logo_estudio'
    );

    /**
     * Método privado para filtrar los parámetros recibidos y evitar errores con las rutas del .htaccess
     */
    private function filtrarParametros($params, $allowed) {
        foreach ($params as $key => $value) {
            // Ignoramos 'url' y cualquier parámetro que empiece por 'id' o sea 'nombre'
            if ($key === 'url' || strpos($key, 'id_estudio') === 0 || $key === 'nombre_estudio') continue;

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
     * Método para validar los datos que se mandan para insertar un registro, comprobar campos obligatorios, valores válidos, etc.
     */
    private function validate($data) {

        if (!isset($data['nombre_estudio']) || empty($data['nombre_estudio'])) {
            $response = array(
                'result' => 'error',
                'details' => 'El campo nombre es obligatorio'
            );

            Response::result(400, $response);
            exit;
        }

        return true;
    }

    /**
     * Método para recuperar registros, pudiendo indicar algunos filtros 
     */
    public function get($params) {
        // Validación de parámetros permitidos y limpieza de basura del .htaccess
        $this->filtrarParametros($params, $this->allowedConditions_get);

        $items = parent::getDB($this->table, $params);

        return $items;
    }

    /**
     * Método para guardar un registro en la base de datos, recibe como parámetro el JSON con los datos a insertar
     */
    public function insert($params) {
        // Validación de parámetros permitidos
        $this->filtrarParametros($params, $this->allowedConditions_insert);

        if ($this->validate($params)) {
            return parent::insertDB($this->table, $params);
        }
    }

    /**
     * Método para actualizar un registro en la base de datos mediante PUT, se indica el id del registro que se quiere actualizar
     */
    public function updatePut($id, $params) {
        // Validación de parámetros permitidos
        $this->filtrarParametros($params, $this->allowedConditions_insert);

        if ($this->validate($params)) {
            $affected_rows = parent::updateDB($this->table, $id, $this->primary_key, $params);

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


    /**
     * Método para actualizar un registro en la base de datos mediante PATCH, se indica el id del registro que se quiere actualizar
     */
    public function updatePatch($id, $params) {
        // Validación de parámetros permitidos
        $this->filtrarParametros($params, $this->allowedConditions_insert);

        $affected_rows = parent::updateDB($this->table, $id, $this->primary_key, $params);

        if ($affected_rows == 0) {
            $response = array(
                'result' => 'error',
                'details' => 'No hubo cambios'
            );

            Response::result(200, $response);
            exit;
        }
    }


    /**
     * Método para borrar un registro de la base de datos, se indica el id del registro que queremos eliminar
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