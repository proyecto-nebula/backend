<?php
namespace App\Classes;
/**
 * Clase para el modelo que representa a la tabla "JUEGOS".
 */
use App\Models\Database;
use App\Utils\Response;

class Games extends Database {

        /**
         * Fuerza los campos numéricos/bool a su tipo en un juego o lista de juegos
         */
        public static function castGameNumericFields($game) {
            $intFields = ['id', 'developer_id', 'publisher_id', 'pegi_id', 'metacritic_score'];
            $boolFields = ['is_featured', 'is_active'];
            if (is_array($game) && isset($game[0]) && is_array($game[0])) {
                foreach ($game as &$item) {
                    $item = self::castGameNumericFields($item);
                }
                return $game;
            }
            if (is_array($game)) {
                foreach ($intFields as $field) {
                    if (isset($game[$field])) {
                        $game[$field] = is_numeric($game[$field]) ? (int)$game[$field] : $game[$field];
                    }
                }
                foreach ($boolFields as $field) {
                    if (isset($game[$field])) {
                        $game[$field] = (bool)$game[$field];
                    }
                }
            }
            return $game;
        }
    private $table = 'games';
    private $primary_key = 'id';

    /**
     * He añadido los sufijos _min y _max para Metacritic y Fecha
     */
    private $allowedConditions_get = array(
        'id', 'title', 'slug', 'release_date', 'metacritic_score', 'pegi_id', 'published_at', 'is_featured', 'is_active', 'developer_id', 'publisher_id'
    );

    private $allowedConditions_insert = array(
        'developer_id', 'publisher_id', 'pegi_id', 'steam_id', 'igdb_id', 'title', 'slug', 'summary', 'description', 'cover_url', 'banner_url', 'hero_url', 'logo_url', 'metacritic_score', 'release_date', 'published_at', 'is_featured', 'is_active'
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
        if (!isset($data['title']) || empty($data['title'])) {
            Response::result(400, array('result' => 'error', 'details' => 'El campo title es obligatorio'));
            exit;
        }
        return true;
    }

    /**
     * Método GET actualizado para usar la nueva lógica de filtrado
     */
    public function get($params) {
        $this->filtrarParametros($params, $this->allowedConditions_get);

        if (isset($params['slug'])) {
            $items = parent::getDB($this->table, ['slug' => $params['slug']]);
            if (count($items) > 0) {
                return self::castGameNumericFields($items[0]);
            } else {
                return null;
            }
        }

        if (isset($params['id'])) {
            $items = parent::getDB($this->table, ['id' => $params['id']]);
            if (count($items) > 0) {
                return self::castGameNumericFields($items[0]);
            } else {
                return null;
            }
        }

        $items = parent::getDB($this->table, $params);
        return self::castGameNumericFields($items);
    }


    public function insert($params) {
        $this->filtrarParametros($params, $this->allowedConditions_insert);
        if ($this->validate($params)) {
            $result = parent::insertDB($this->table, $params);
            return self::castGameNumericFields($result);
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