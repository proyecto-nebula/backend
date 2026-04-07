<?php
/**
 * Clase para el modelo que representa a la tabla "CAPTURAS".
 */
require_once __DIR__ . '/../utils/response.php';
require_once __DIR__ . '/../models/database.php';

class capturas extends Database {
    /**
     * Atributo que indica la tabla asociada a la clase del modelo
     */
    private $table = 'capturas';

    /**
     * Atributo que indica la columna que es primary key en la tabla
     */
    private $primary_key = 'id_captura';


    /**
     * Array con los campos de la tabla que se pueden usar como filtro para recuperar registros
     */
    private $allowedConditions_get = array(
        'id_juego',
        'page'
    );

    /**
     * Array con los campos de la tabla que se pueden proporcionar para insertar registros
     */
    private $allowedConditions_insert = array(
        'id_juego',
        'imagen'
    );

    /**
     * Método privado para filtrar los parámetros recibidos y evitar errores con las rutas del .htaccess
     */
   private function filtrarParametros($params, $allowed) {
        foreach ($params as $key => $value) {
    //         // Ignoramos 'url' y cualquier parámetro que empiece por 'id' (id_captura, id_juego, id...)
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
     * Método para validar los datos que se mandan para insertar un registro, comprobar campos obligatorios, valores válidos, etc.
     */
    private function validate($data) {

        if (!isset($data['id_juego']) || empty($data['id_juego']) || !isset($data['imagen']) || empty($data['imagen'])) {
            $response = array(
                'result' => 'error',
                'details' => 'Los campos id_juego e imagen son obligatorios'
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