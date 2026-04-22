<?php
namespace App\Classes;
/**
 * Clase para el modelo que representa a la tabla "FAVORITOS".
 */
use App\Models\Database;
use App\Utils\Response;

class Favorites extends Database {
    private $table = 'favorites';
    private $primary_key = 'user_id';

    private $allowedConditions_get = array(
        'user_id',
        'game_id',
    );

    private $allowedConditions_insert = array(
        'user_id',
        'game_id'
    );

    /**
     * UN SOLO MÉTODO INSERT: Con control de duplicados y claves foráneas
     */
    public function insert($params) {
        $this->filtrarParametros($params, $this->allowedConditions_insert);

        if ($this->validate($params)) {
            try {
                return parent::insertDB($this->table, $params);
            } catch (\mysqli_sql_exception $e) {
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
        if (!isset($data['user_id']) || strlen((string)$data['user_id']) === 0) {
            Response::result(400, array('result' => 'error', 'details' => 'El campo user_id es obligatorio'));
            exit;
        }

        if (!isset($data['game_id']) || strlen((string)$data['game_id']) === 0) {
            Response::result(400, array('result' => 'error', 'details' => 'El campo game_id es obligatorio'));
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

    public function deleteFavorito($user_id, $game_id) {
        $sql = "DELETE FROM $this->table WHERE user_id = $user_id AND game_id = $game_id";
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
            if ($key === 'url' || $key === 'user_id' || $key === 'game_id') continue;
            if (!in_array($key, $allowed)) {
                Response::result(400, array('result' => 'error', 'details' => "El campo '$key' no es válido"));
                exit;
            }
        }
    }
}
?>