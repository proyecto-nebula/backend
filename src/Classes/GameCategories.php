<?php
namespace App\Classes;
/**
 * Clase para el modelo que representa a la tabla "JUEGOS_CATEGORIAS".
 */
use App\Models\Database;
use App\Utils\Response;

class GameCategories extends Database {
    private $table = 'game_categories';
    private $primary_key = 'game_id';

    private $allowedConditions_get = array('game_id', 'category_id');
    private $allowedConditions_insert = array('game_id', 'category_id');

    /**
     * Mueve el método filtrarParametros arriba o asegúrate de que esté bien escrito
     */
    private function filtrarParametros($params, $allowed) {
        if (!is_array($params)) return;
        
        foreach ($params as $key => $value) {
            // Ignoramos parámetros de sistema y IDs principales
            if ($key === 'url' || $key === 'game_id' || $key === 'category_id') continue;

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
        if (!isset($data['game_id']) || !isset($data['category_id'])) {
            Response::result(400, array('result' => 'error', 'details' => 'Faltan campos obligatorios'));
            exit;
        }
        return true;
    }

    public function get($params) {
        $this->filtrarParametros($params, $this->allowedConditions_get);
        return parent::getDB($this->table, $params);
    }

    public function insert($params) {
        // Primero filtramos, luego validamos
        $this->filtrarParametros($params, $this->allowedConditions_insert);

        if ($this->validate($params)) {
            try {
                return parent::insertDB($this->table, $params);
            } catch (\mysqli_sql_exception $e) {
                if ($e->getCode() == 1062) {
                    Response::result(400, array(
                        'result' => 'error',
                        'details' => 'Este juego ya tiene asignada esta categoría'
                    ));
                    exit;
                }

                if ($e->getCode() == 1452) {
                    Response::result(404, array(
                        'result' => 'error',
                        'details' => 'El juego o la categoría indicados no existen'
                    ));
                    exit;
                }
                throw $e;
            }
        }
    }

    /**
     * Método para borrar la relación específica
     */
    public function deleteRelacion($game_id, $category_id) {
        $sql = "DELETE FROM $this->table WHERE game_id = $game_id AND category_id = $category_id";
        $db = $this->getConnection();
        $db->query($sql);

        if ($db->affected_rows === 0) {
            Response::result(404, array('result' => 'error', 'details' => 'No existe esa combinación de juego y categoría'));
            exit;
        }
        return true;
    }
}