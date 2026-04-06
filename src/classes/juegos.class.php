<?php
/**
 * Clase para el modelo que representa a la tabla "JUEGOS".
 */
require_once __DIR__ . '/../utils/response.php';
require_once __DIR__ . '/../models/database.php';

class juegos extends Database {
    private $table = 'JUEGOS';
    private $primary_key = 'id_juego';

    /**
     * He añadido los sufijos _min y _max para Metacritic y Fecha
     */
    private $allowedConditions_get = array(
        'id_juego', 'titulo', 'id_desarrollador', 'destacado', 'id_pegi',
        'id_steam', 'id_igdb', 'metacritic', 'metacritic_min', 'metacritic_max',
        'fecha_lanzamiento', 'fecha_lanzamiento_min', 'fecha_lanzamiento_max',
        'fecha_publicacion', 'hero', 'page'
    );

    private $allowedConditions_insert = array(
        'id_desarrollador', 'id_distribuidor', 'id_pegi', 'id_steam', 'id_igdb',
        'titulo', 'descripcion_corta', 'descripcion_larga', 'portada_v', 
        'portada_h', 'hero', 'logo', 'metacritic', 'fecha_lanzamiento', 'destacado'
    );

    /**
     * Filtra parámetros y permite rutas amigables + rangos
     */
    private function filtrarParametros($params, $allowed) {
        foreach ($params as $key => $value) {
            // Permitimos 'url', cualquier ID, y los sufijos de rango
            if ($key === 'url' || strpos($key, 'id') === 0 || str_ends_with($key, '_min') || str_ends_with($key, '_max')) continue;

            if (!in_array($key, $allowed)) {
                Response::result(400, ["details" => "Campo no permitido: $key"]);
                exit;
            }
        }
    }

    private function validate($data) {
        if (!isset($data['titulo']) || empty($data['titulo'])) {
            Response::result(400, array('result' => 'error', 'details' => 'El campo titulo es obligatorio'));
            exit;
        }
        return true;
    }

    /**
     * Método GET actualizado para usar la nueva lógica de filtrado
     */
    public function get($params) {
        // Usamos nuestra función de filtrado en lugar del bucle antiguo
        $this->filtrarParametros($params, $this->allowedConditions_get);

        $items = parent::getDB($this->table, $params);
        return $items;
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