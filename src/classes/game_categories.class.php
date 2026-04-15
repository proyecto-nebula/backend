<?php
/**
 * Clase para el modelo que representa a la tabla "JUEGOS_CATEGORIAS".
 */
require_once __DIR__ . '/../utils/response.php';
require_once __DIR__ . '/../models/database.php';

class juegos_categorias extends Database {
    private $table = 'juegos_categorias';
    private $primary_key = 'id_juego';

    private $allowedConditions_get = array('id_juego', 'id_categoria');
    private $allowedConditions_insert = array('id_juego', 'id_categoria');

    /**
     * Mueve el método filtrarParametros arriba o asegúrate de que esté bien escrito
     */
    private function filtrarParametros($params, $allowed) {
        if (!is_array($params)) return;
        
        foreach ($params as $key => $value) {
            // Ignoramos parámetros de sistema y IDs principales
            if ($key === 'url' || $key === 'id_juego' || $key === 'id_categoria') continue;

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
        if (!isset($data['id_juego']) || !isset($data['id_categoria'])) {
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
            } catch (mysqli_sql_exception $e) {
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
    public function deleteRelacion($id_juego, $id_categoria) {
        $sql = "DELETE FROM $this->table WHERE id_juego = $id_juego AND id_categoria = $id_categoria";
        $db = $this->getConnection();
        $db->query($sql);

        if ($db->affected_rows === 0) {
            Response::result(404, array('result' => 'error', 'details' => 'No existe esa combinación de juego y categoría'));
            exit;
        }
        return true;
    }
}