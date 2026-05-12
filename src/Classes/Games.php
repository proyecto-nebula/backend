<?php
namespace App\Classes;

use App\Models\Database;
use App\Utils\Response;
use App\Core\IgdbService;

/**
 * Clase para el modelo que representa a la tabla "games".
 */
class Games extends Database {

    private $table = 'games';
    private $primary_key = 'id';

    /**
     * Obtiene los datos de un estudio por su id
     */
    private function getStudioById($studioId) {
        if (!$studioId) return null;
        $conn = $this->getConnection();
        $sql = "SELECT id, name, logo_url, website FROM studios WHERE id = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('i', $studioId);
        $stmt->execute();
        $result = $stmt->get_result();
        $studio = $result->fetch_assoc();
        $stmt->close();
        return $studio ?: null;
    }

    /**
     * Obtiene las categorías asociadas a un juego por su id
     */
    private function getCategoriesForGame($gameId) {
        $conn = $this->getConnection();
        $sql = "SELECT c.id, c.name, c.image_url FROM game_categories gc JOIN categories c ON gc.category_id = c.id WHERE gc.game_id = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('i', $gameId);
        $stmt->execute();
        $result = $stmt->get_result();
        $categories = [];
        while ($row = $result->fetch_assoc()) {
            $categories[] = $row;
        }
        $stmt->close();
        return $categories;
    }

    /**
     * He añadido los sufijos _min y _max para Metacritic y Fecha
     */
    private $allowedConditions_get = array(
        'id', 'title', 'slug', 'release_date', 'metacritic_score', 'pegi_id', 'published_at', 'is_featured', 'is_active', 'developer_id', 'publisher_id', 'steam_id', 'igdb_id', 'view'
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
                $game = $items[0];
                $game['categories'] = $this->getCategoriesForGame($game['id']);
                $game['developer'] = $this->getStudioById($game['developer_id']);
                $game['publisher'] = $this->getStudioById($game['publisher_id']);
                // Si pedimos la vista de detalle, adjuntar screenshots (limit fijo 10)
                if (isset($params['view']) && $params['view'] === 'detail') {
                    $igdb = new IgdbService();
                    $game['screenshots'] = !empty($game['igdb_id']) ? $igdb->getScreenshots((int)$game['igdb_id'], 10) : [];
                }
                return $game;
            } else {
                return null;
            }
        }

        if (isset($params['id'])) {
            $items = parent::getDB($this->table, ['id' => $params['id']]);
            if (count($items) > 0) {
                $game = $items[0];
                $game['categories'] = $this->getCategoriesForGame($game['id']);
                $game['developer'] = $this->getStudioById($game['developer_id']);
                $game['publisher'] = $this->getStudioById($game['publisher_id']);
                if (isset($params['view']) && $params['view'] === 'detail') {
                    $igdb = new IgdbService();
                    $game['screenshots'] = !empty($game['igdb_id']) ? $igdb->getScreenshots((int)$game['igdb_id'], 10) : [];
                }
                return $game;
            } else {
                return null;
            }
        }

        $items = parent::getDB($this->table, $params);
        $games = $items;
        // Embedding para lista
        foreach ($games as &$game) {
            $game['categories'] = $this->getCategoriesForGame($game['id']);
            $game['developer'] = $this->getStudioById($game['developer_id']);
            $game['publisher'] = $this->getStudioById($game['publisher_id']);
        }
        // Si pedimos vista de detalle para una lista, hacemos un batch (limit fijo 10)
        if (isset($params['view']) && $params['view'] === 'detail') {
            $igdbIds = [];
            foreach ($games as $g) {
                if (!empty($g['igdb_id'])) $igdbIds[] = (int)$g['igdb_id'];
            }
            $igdbIds = array_values(array_unique($igdbIds));
            if (count($igdbIds) > 0 && count($igdbIds) <= 25) {
                $igdb = new IgdbService();
                $screensMap = $igdb->getScreenshotsForGames($igdbIds, 10);
                foreach ($games as &$g) {
                    $g['screenshots'] = (!empty($g['igdb_id']) && isset($screensMap[(int)$g['igdb_id']])) ? $screensMap[(int)$g['igdb_id']] : [];
                }
                unset($g);
            }
        }
        return $games;
    }


    public function insert($params) {
        $this->filtrarParametros($params, $this->allowedConditions_insert);
        if ($this->validate($params)) {
            $result = parent::insertDB($this->table, $params);
            return $result;
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

    /**
     * Devuelve los juegos más reproducidos (por número de sesiones)
     */
    public function getMostPlayed($limit = 10) {
        $conn = $this->getConnection();
        $sql = "SELECT g.*, COUNT(s.id) AS play_count FROM {$this->table} g JOIN sessions s ON s.game_id = g.id GROUP BY g.id ORDER BY play_count DESC LIMIT ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('i', $limit);
        $stmt->execute();
        $result = $stmt->get_result();
        $games = [];
        while ($row = $result->fetch_assoc()) {
            $games[] = $row;
        }
        $stmt->close();

        foreach ($games as &$game) {
            $game['categories'] = $this->getCategoriesForGame($game['id']);
            $game['developer'] = $this->getStudioById($game['developer_id']);
            $game['publisher'] = $this->getStudioById($game['publisher_id']);
        }
        return $games;
    }

    /**
     * Devuelve los juegos marcados como destacados
     */
    public function getFeatured($limit = 10) {
        $conn = $this->getConnection();
        $sql = "SELECT * FROM {$this->table} WHERE is_featured = 1 ORDER BY published_at DESC LIMIT ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('i', $limit);
        $stmt->execute();
        $result = $stmt->get_result();
        $games = [];
        while ($row = $result->fetch_assoc()) {
            $games[] = $row;
        }
        $stmt->close();

        foreach ($games as &$game) {
            $game['categories'] = $this->getCategoriesForGame($game['id']);
            $game['developer'] = $this->getStudioById($game['developer_id']);
            $game['publisher'] = $this->getStudioById($game['publisher_id']);
        }
        return $games;
    }

    /**
     * Devuelve varias colecciones útiles en una sola respuesta
     */
    public function getCollections($limit = 10) {
        $collections = [];

        // Featured
        $collections['featured'] = $this->getFeatured($limit);

        // Novedades (ordenadas por published_at)
        $conn = $this->getConnection();
        $sql = "SELECT * FROM {$this->table} WHERE published_at IS NOT NULL ORDER BY published_at DESC LIMIT ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('i', $limit);
        $stmt->execute();
        $result = $stmt->get_result();
        $novedades = [];
        while ($row = $result->fetch_assoc()) {
            $novedades[] = $row;
        }
        $stmt->close();
        $collections['novedades'] = $novedades;
        foreach ($collections['novedades'] as &$g) {
            $g['categories'] = $this->getCategoriesForGame($g['id']);
            $g['developer'] = $this->getStudioById($g['developer_id']);
            $g['publisher'] = $this->getStudioById($g['publisher_id']);
        }

        // Nuevos juegos (ordenados por release_date)
        $sql = "SELECT * FROM {$this->table} WHERE release_date IS NOT NULL ORDER BY release_date DESC LIMIT ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('i', $limit);
        $stmt->execute();
        $result = $stmt->get_result();
        $nuevos = [];
        while ($row = $result->fetch_assoc()) {
            $nuevos[] = $row;
        }
        $stmt->close();
        $collections['nuevos'] = $nuevos;
        foreach ($collections['nuevos'] as &$g) {
            $g['categories'] = $this->getCategoriesForGame($g['id']);
            $g['developer'] = $this->getStudioById($g['developer_id']);
            $g['publisher'] = $this->getStudioById($g['publisher_id']);
        }

        // Most played
        $collections['most_played'] = $this->getMostPlayed($limit);

        return $collections;
    }
}
