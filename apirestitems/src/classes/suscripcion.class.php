<?php
/**
 * Clase para el modelo que representa a la tabla "SUSCRIPCION".
 */
require_once 'src/response.php';
require_once 'src/database.php';

class suscripcion extends Database {
    /**
     * Atributo que indica la tabla asociada a la clase del modelo
     */
    private $table = 'SUSCRIPCION';

    /**
     * Atributo que indica la columna que es primary key en la tabla
     */
    private $primary_key = 'id_suscripcion';


    /**
     * Array con los campos permitidos para GET. 
     * He añadido precio_min y precio_max para que el validador no los rechace.
     */
    private $allowedConditions_get = array(
        'id_suscripcion',
        'nombre',
        'precio',
        'precio_min',
        'precio_max',
        'page'
    );

    /**
     * Array con los campos permitidos para INSERT/UPDATE
     */
    private $allowedConditions_insert = array(
        'nombre',
        'descripcion',
        'precio'
    );

    /**
     * Método privado para filtrar los parámetros recibidos.
     * Actualizado para soportar los sufijos _min y _max de tu nueva Database.
     */
    private function filtrarParametros($params, $allowed) {
        foreach ($params as $key => $value) {
            // Permitimos 'url', IDs, nombres, y cualquier campo que termine en _min o _max
            if ($key === 'url' || strpos($key, 'id') === 0 || $key === 'nombre' || str_ends_with($key, '_min') || str_ends_with($key, '_max')) continue;

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
     * Método para validar los datos obligatorios
     */
    private function validate($data) {
        if (!isset($data['nombre']) || empty($data['nombre'])) {
            Response::result(400, array(
                'result' => 'error',
                'details' => 'El campo nombre es obligatorio'
            ));
            exit;
        }
        return true;
    }

    /**
     * Recuperar registros con soporte para rangos
     */
    public function get($params) {
        $this->filtrarParametros($params, $this->allowedConditions_get);
        return parent::getDB($this->table, $params);
    }

    /**
     * Insertar registro
     */
    public function insert($params) {
        $this->filtrarParametros($params, $this->allowedConditions_insert);
        if ($this->validate($params)) {
            return parent::insertDB($this->table, $params);
        }
    }

    /**
     * Actualización total (PUT)
     */
    public function updatePut($id, $params) {
        $this->filtrarParametros($params, $this->allowedConditions_insert);
        if ($this->validate($params)) {
            $affected_rows = parent::updateDB($this->table, $id, $this->primary_key, $params);
            if ($affected_rows == 0) {
                Response::result(200, array('result' => 'error', 'details' => 'No hubo cambios'));
                exit;
            }
        }
    }

    /**
     * Actualización parcial (PATCH)
     */
    public function updatePatch($id, $params) {
        $this->filtrarParametros($params, $this->allowedConditions_insert);
        $affected_rows = parent::updateDB($this->table, $id, $this->primary_key, $params);
        if ($affected_rows == 0) {
            Response::result(200, array('result' => 'error', 'details' => 'No hubo cambios'));
            exit;
        }
    }

    /**
     * Borrar registro
     */
    public function delete($id) {
        $affected_rows = parent::deleteDB($this->table, $id, $this->primary_key);
        if ($affected_rows == 0) {
            Response::result(200, array('result' => 'error', 'details' => 'No hubo cambios'));
            exit;
        }
    }
}
?>