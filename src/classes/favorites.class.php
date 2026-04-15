<?php
/**
 * Clase para el modelo que representa a la tabla "FAVORITOS".
 */
require_once __DIR__ . '/../utils/response.php';
require_once __DIR__ . '/../models/database.php';

class favoritos extends Database {
    private $table = 'favoritos';
    private $primary_key = 'id_usuario';

    private $allowedConditions_get = array(
        'id_usuario', 
        'id_juego', 
    );

    private $allowedConditions_insert = array(
        'id_usuario', 
        'id_juego'
    );

    /**
     * UN SOLO MÉTODO INSERT: Con control de duplicados y claves foráneas
     */
    public function insert($params) {
        $this->filtrarParametros($params, $this->allowedConditions_insert);

        if ($this->validate($params)) {
            try {
                return parent::insertDB($this->table, $params);
            } catch (mysqli_sql_exception $e) {
                // Capturar duplicados (Código 1062)
                if ($e->getCode() == 1062) {
                    Response::result(400, array(
                        'result' => 'error',
                        'details' => 'Este juego ya está en tu lista de favoritos'
                    ));
                    exit;
                }

                // Capturar IDs inexistentes (Código 1452)
                if ($e->getCode() == 1452) {
                    Response::result(404, array(
                        'result' => 'error',
                        'details' => 'El usuario o el juego indicado no existen'
                    ));
                    exit;
                }
                
                throw $e;
            }
        }
    }

    private function validate($data) {
        if (!isset($data['id_usuario']) || strlen((string)$data['id_usuario']) === 0) {
            Response::result(400, array('result' => 'error', 'details' => 'El campo id_usuario es obligatorio'));
            exit;
        }

        if (!isset($data['id_juego']) || strlen((string)$data['id_juego']) === 0) {
            Response::result(400, array('result' => 'error', 'details' => 'El campo id_juego es obligatorio'));
            exit;
        }
        return true;
    }

    public function get($params) {
        $this->filtrarParametros($params, $this->allowedConditions_get);
        return parent::getDB($this->table, $params);
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

    public function deleteFavorito($id_usuario, $id_juego) {
        $sql = "DELETE FROM $this->table WHERE id_usuario = $id_usuario AND id_juego = $id_juego";
        $db = $this->getConnection();
        $db->query($sql);

        if (!$db->affected_rows) {
            Response::result(404, array('result' => 'error', 'details' => 'No se encontró ese favorito'));
            exit;
        }
        return true;
    }

    private function filtrarParametros($params, $allowed) {
        foreach ($params as $key => $value) {
            if ($key === 'url' || $key === 'id_usuario' || $key === 'id_juego') continue;
            if (!in_array($key, $allowed)) {
                Response::result(400, array('result' => 'error', 'details' => "El campo '$key' no es válido"));
                exit;
            }
        }
    }
}
?>