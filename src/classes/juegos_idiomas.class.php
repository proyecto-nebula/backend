<?php
/**
 * Clase para el modelo que representa a la tabla "JUEGOS_IDIOMAS".
 */
require_once 'src/response.php';
require_once 'src/database.php';

class JUEGOS_IDIOMAS extends Database {
    private $table = 'JUEGOS_IDIOMAS';
    private $primary_key = 'id_juego';

    private $allowedConditions_get = array('id_juego', 'id_idioma', 'page');
    private $allowedConditions_insert = array('id_juego', 'id_idioma');

    private function validate($data) {
        if (!isset($data['id_juego']) || !isset($data['id_idioma'])) {
            Response::result(400, array('result' => 'error', 'details' => 'Faltan campos obligatorios'));
            exit;
        }
        return true;
    }

    public function get($params) {
        return parent::getDB($this->table, $params);
    }

    public function insert($params) {
        if ($this->validate($params)) {
            return parent::insertDB($this->table, $params);
        }
    }

    public function delete($id_juego) {
        return parent::deleteDB($this->table, $id_juego, $this->primary_key);
    }
}
?>