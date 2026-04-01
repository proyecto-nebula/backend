<?php
/**
 * Clase para el modelo que representa a la tabla "USUARIOS".
 */
require_once 'src/response.php';
require_once 'src/database.php';

class usuarios extends Database {
    private $table = 'USUARIOS';
    private $primary_key = 'id_usuario';

    /**
     * Solo permitimos buscar por ID, Token y Fecha de creación (y sus rangos)
     */
    private $allowedConditions_get = array(
        'id_usuario',
        'token',
        'page'
    );

    private $allowedConditions_insert = array(
        'id_suscripcion', 'id_pais', 'id_rol', 'usuario', 'password', 'nombre', 'apellidos', 'email', 'id_avatar'
    );

    /**
     * Ajustamos el filtro para que sea estricto con los campos solicitados
     */
    private function filtrarParametros($params, $allowed) {
        foreach ($params as $key => $value) {
            // Permitimos 'url', cualquier campo que empiece por 'id' (para la ruta amigable),
            // el token, y los rangos de fecha.
            if ($key === 'url' || 
                strpos($key, 'id') === 0 || 
                $key === 'token' || 
                str_ends_with($key, '_min') || 
                str_ends_with($key, '_max')) continue;

            if (!in_array($key, $allowed)) {
                Response::result(400, array(
                    'result' => 'error',
                    'details' => "El campo '$key' no es válido para esta consulta"
                ));
                exit;
            }
        }
    }

    private function validate($data) {
        if (!isset($data['usuario']) || empty($data['usuario']) || !isset($data['email']) || empty($data['email']) || !isset($data['password']) || empty($data['password'])) {
            Response::result(400, array(
                'result' => 'error',
                'details' => 'Los campos usuario, email y password son obligatorios'
            ));
            exit;
        }
        return true;
    }

    public function get($params) {
        $this->filtrarParametros($params, $this->allowedConditions_get);
        return parent::getDB($this->table, $params);
    }

    public function insert($params) {
        $this->filtrarParametros($params, $this->allowedConditions_insert);
        if ($this->validate($params)) {
            return parent::insertDB($this->table, $params);
        }
    }

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

    public function updatePatch($id, $params) {
        $this->filtrarParametros($params, $this->allowedConditions_insert);
        $affected_rows = parent::updateDB($this->table, $id, $this->primary_key, $params);
        if ($affected_rows == 0) {
            Response::result(200, array('result' => 'error', 'details' => 'No hubo cambios'));
            exit;
        }
    }

    public function delete($id) {
        $affected_rows = parent::deleteDB($this->table, $id, $this->primary_key);
        if ($affected_rows == 0) {
            Response::result(200, array('result' => 'error', 'details' => 'No hubo cambios'));
            exit;
        }
    }
}
?>