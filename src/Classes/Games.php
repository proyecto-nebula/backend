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
     * Obtiene los datos de pegi por su id
     */
    private function getPegiById($pegiId) {
        if (!$pegiId) return null;
        $conn = $this->getConnection();
        $sql = "SELECT id, name, image_url FROM pegi WHERE id = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('i', $pegiId);
        $stmt->execute();
        $result = $stmt->get_result();
        $pegi = $result->fetch_assoc();
        $stmt->close();
        return $pegi ?: null;
    }

    /**
     * Obtiene los datos de un estudio por su id
     */
    private function getStudioById($studioId) {
        if (!$studioId) return null;
        $conn = $this->getConnection();
        $sql = "SELECT id, name FROM studios WHERE id = ?";
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
        if (isset($params['collection'])) {
            $limitRequested = isset($params['limit']);
            $limit  = $limitRequested ? max(1, min(200, intval($params['limit']))) : 10;
            $userId = isset($params['user_id']) ? intval($params['user_id']) : null;
            $slug   = $params['slug'] ?? null;

            switch ($params['collection']) {
                case 'recently_published': return $this->getRecentlyPublished($limit);
                case 'new_releases':       return $this->getNewReleases($limit);
                case 'favorites':          return $userId !== null ? $this->getFavoriteGames($userId, $limitRequested ? $limit : null) : [];
                case 'last_played':        return $userId !== null ? $this->getLastPlayedGames($userId, $limit)  : [];
                case 'most_played_by':     return $userId !== null ? $this->getMostPlayedByUser($userId, $limit) : $this->getMostPlayed($limit);
                case 'trending_today':     return $this->getMostPlayedInPeriod('24 HOUR', $limit);
                case 'trending_week':      return $this->getMostPlayedInPeriod('7 DAY',   $limit);
                case 'trending_month':     return $this->getMostPlayedInPeriod('30 DAY',  $limit);
                case 'most_favorited':     return $this->getMostFavorited($limit);
                case 'recommended':        return $userId !== null ? $this->getRecommended($userId, $limit) : [];
                case 'similar':            return $slug   ? $this->getSimilarGames($slug, $limit)     : [];
                case 'by_developer':       return $slug   ? $this->getGamesByDeveloper($slug, $limit) : [];
                default:
                    Response::error('Colecci\u00f3n no v\u00e1lida', 400);
                    exit;
            }
        }

        $this->filtrarParametros($params, $this->allowedConditions_get);

        if (isset($params['slug'])) {
            $items = parent::getDB($this->table, ['slug' => $params['slug']]);
            if (count($items) > 0) {
                $game = $items[0];
                $game['categories'] = $this->getCategoriesForGame($game['id']);
                $game['developer'] = $this->getStudioById($game['developer_id']);
                $game['publisher'] = $this->getStudioById($game['publisher_id']);
                $game['pegi'] = $this->getPegiById($game['pegi_id']);
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
                $game['pegi'] = $this->getPegiById($game['pegi_id']);
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
            $game['pegi'] = $this->getPegiById($game['pegi_id']);
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

    private function getMostPlayedInPeriod(string $interval, int $limit = 10): array {
        $conn = $this->getConnection();
        $sql  = "SELECT g.*, SUM(COALESCE(s.duration, 0)) AS total_duration
                 FROM {$this->table} g
                 LEFT JOIN sessions s ON s.game_id = g.id
                     AND s.started_at >= NOW() - INTERVAL $interval
                 GROUP BY g.id
                 ORDER BY total_duration DESC, RAND()
                 LIMIT ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('i', $limit);
        $stmt->execute();
        $games = [];
        $result = $stmt->get_result();
        while ($row = $result->fetch_assoc()) $games[] = $row;
        $stmt->close();
        foreach ($games as &$g) {
            $g['categories'] = $this->getCategoriesForGame($g['id']);
            $g['developer']  = $this->getStudioById($g['developer_id']);
            $g['publisher']  = $this->getStudioById($g['publisher_id']);
            $g['pegi'] = $this->getPegiById($g['pegi_id']);
}
        return $games;
    }

    private function getMostFavorited(int $limit = 10): array {
        $conn = $this->getConnection();
        $sql  = "SELECT g.*, COUNT(f.user_id) AS favorite_count
                 FROM {$this->table} g
                 JOIN favorites f ON f.game_id = g.id
                 GROUP BY g.id
                 ORDER BY favorite_count DESC
                 LIMIT ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('i', $limit);
        $stmt->execute();
        $games = [];
        $result = $stmt->get_result();
        while ($row = $result->fetch_assoc()) $games[] = $row;
        $stmt->close();
        foreach ($games as &$g) {
            $g['categories'] = $this->getCategoriesForGame($g['id']);
            $g['developer']  = $this->getStudioById($g['developer_id']);
            $g['publisher']  = $this->getStudioById($g['publisher_id']);
            $g['pegi'] = $this->getPegiById($g['pegi_id']);
}
        return $games;
    }

    private function getRecentlyPublished(int $limit = 10): array {
        $conn = $this->getConnection();
        $sql  = "SELECT * FROM {$this->table} WHERE published_at IS NOT NULL ORDER BY published_at DESC LIMIT ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('i', $limit);
        $stmt->execute();
        $games = [];
        $result = $stmt->get_result();
        while ($row = $result->fetch_assoc()) $games[] = $row;
        $stmt->close();
        foreach ($games as &$g) {
            $g['categories'] = $this->getCategoriesForGame($g['id']);
            $g['developer']  = $this->getStudioById($g['developer_id']);
            $g['publisher']  = $this->getStudioById($g['publisher_id']);
            $g['pegi'] = $this->getPegiById($g['pegi_id']);
}
        return $games;
    }

    private function getNewReleases(int $limit = 10): array {
        $conn = $this->getConnection();
        $sql  = "SELECT * FROM {$this->table} WHERE release_date IS NOT NULL ORDER BY release_date DESC LIMIT ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('i', $limit);
        $stmt->execute();
        $games = [];
        $result = $stmt->get_result();
        while ($row = $result->fetch_assoc()) $games[] = $row;
        $stmt->close();
        foreach ($games as &$g) {
            $g['categories'] = $this->getCategoriesForGame($g['id']);
            $g['developer']  = $this->getStudioById($g['developer_id']);
            $g['publisher']  = $this->getStudioById($g['publisher_id']);
            $g['pegi'] = $this->getPegiById($g['pegi_id']);
}
        return $games;
    }

    private function getFavoriteGames(int $userId, ?int $limit = null): array {
        $conn = $this->getConnection();
        $sql  = "SELECT g.* FROM {$this->table} g
                 JOIN favorites f ON f.game_id = g.id
                 WHERE f.user_id = ?";
        if ($limit !== null) $sql .= ' LIMIT ?';
        $stmt = $conn->prepare($sql);
        if ($limit !== null) {
            $stmt->bind_param('ii', $userId, $limit);
        } else {
            $stmt->bind_param('i', $userId);
        }
        $stmt->execute();
        $games = [];
        $result = $stmt->get_result();
        while ($row = $result->fetch_assoc()) $games[] = $row;
        $stmt->close();
        foreach ($games as &$g) {
            $g['categories'] = $this->getCategoriesForGame($g['id']);
            $g['developer']  = $this->getStudioById($g['developer_id']);
            $g['publisher']  = $this->getStudioById($g['publisher_id']);
            $g['pegi'] = $this->getPegiById($g['pegi_id']);
}
        return $games;
    }

    private function getLastPlayedGames(int $userId, int $limit = 10): array {
        $conn = $this->getConnection();
        $sql  = "SELECT g.*, MAX(s.started_at) AS last_played
                 FROM {$this->table} g
                 JOIN sessions s ON s.game_id = g.id
                 WHERE s.user_id = ?
                 GROUP BY g.id
                 ORDER BY last_played DESC
                 LIMIT ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('ii', $userId, $limit);
        $stmt->execute();
        $games = [];
        $result = $stmt->get_result();
        while ($row = $result->fetch_assoc()) $games[] = $row;
        $stmt->close();
        foreach ($games as &$g) {
            $g['categories'] = $this->getCategoriesForGame($g['id']);
            $g['developer']  = $this->getStudioById($g['developer_id']);
            $g['publisher']  = $this->getStudioById($g['publisher_id']);
            $g['pegi'] = $this->getPegiById($g['pegi_id']);
}
        return $games;
    }

    private function getMostPlayedByUser(int $userId, int $limit = 10): array {
        $conn = $this->getConnection();
        $sql  = "SELECT g.*, SUM(COALESCE(s.duration, 0)) AS total_duration
                 FROM {$this->table} g
                 JOIN sessions s ON s.game_id = g.id
                 WHERE s.user_id = ?
                 GROUP BY g.id
                 ORDER BY total_duration DESC
                 LIMIT ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('ii', $userId, $limit);
        $stmt->execute();
        $games = [];
        $result = $stmt->get_result();
        while ($row = $result->fetch_assoc()) $games[] = $row;
        $stmt->close();
        foreach ($games as &$g) {
            $g['categories'] = $this->getCategoriesForGame($g['id']);
            $g['developer']  = $this->getStudioById($g['developer_id']);
            $g['publisher']  = $this->getStudioById($g['publisher_id']);
            $g['pegi'] = $this->getPegiById($g['pegi_id']);
}
        return $games;
    }

    /**
     * Devuelve los juegos más reproducidos (por duración total de sesiones)
     */
    public function getMostPlayed($limit = 10) {
        $conn = $this->getConnection();
        $sql = "SELECT g.*, SUM(COALESCE(s.duration, 0)) AS total_duration FROM {$this->table} g JOIN sessions s ON s.game_id = g.id GROUP BY g.id ORDER BY total_duration DESC LIMIT ?";
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
            $game['pegi']    = $this->getPegiById($game['pegi_id']);
        }
        return $games;
    }

    private function getRecommended(int $userId, int $limit = 10): array {
        $conn = $this->getConnection();
        $sql = "
            SELECT g.*,
                COALESCE(SUM(cw.weight), 1)
                * COALESCE(1 + (g.metacritic_score - 50) / 100.0, 1.0)
                * IF(g.is_featured = 1, 1.3, 1.0) AS recommendation_score
            FROM {$this->table} g
            LEFT JOIN game_categories gc ON gc.game_id = g.id
            LEFT JOIN (
                SELECT category_id, SUM(w) AS weight
                FROM (
                    SELECT gc2.category_id, 3 AS w
                    FROM favorites f
                    JOIN game_categories gc2 ON gc2.game_id = f.game_id
                    WHERE f.user_id = ?
                    UNION ALL
                    SELECT gc2.category_id, COALESCE(s.duration, 0) AS w
                    FROM sessions s
                    JOIN game_categories gc2 ON gc2.game_id = s.game_id
                    WHERE s.user_id = ?
                ) raw
                GROUP BY category_id
            ) cw ON cw.category_id = gc.category_id
            WHERE g.id NOT IN (
                SELECT game_id FROM favorites WHERE user_id = ?
                UNION
                SELECT game_id FROM sessions WHERE user_id = ?
            )
            GROUP BY g.id
            ORDER BY recommendation_score DESC
            LIMIT ?
        ";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('iiiii', $userId, $userId, $userId, $userId, $limit);
        $stmt->execute();
        $games = [];
        $result = $stmt->get_result();
        while ($row = $result->fetch_assoc()) $games[] = $row;
        $stmt->close();
        foreach ($games as &$g) {
            $g['categories'] = $this->getCategoriesForGame($g['id']);
            $g['developer']  = $this->getStudioById($g['developer_id']);
            $g['publisher']  = $this->getStudioById($g['publisher_id']);
            $g['pegi'] = $this->getPegiById($g['pegi_id']);
}
        return $games;
    }

    private function getSimilarGames(string $slug, int $limit = 10): array {
        $conn = $this->getConnection();
        $stmt = $conn->prepare("SELECT id FROM {$this->table} WHERE slug = ?");
        $stmt->bind_param('s', $slug);
        $stmt->execute();
        $row = $stmt->get_result()->fetch_assoc();
        $stmt->close();
        if (!$row) return [];
        $gameId = $row['id'];

        $sql = "
            SELECT g.*, COUNT(DISTINCT gc_match.category_id) AS shared_cats
            FROM {$this->table} g
            JOIN game_categories gc_match
                ON gc_match.game_id = g.id
                AND gc_match.category_id IN (SELECT category_id FROM game_categories WHERE game_id = ?)
            WHERE g.id != ?
            GROUP BY g.id
            ORDER BY shared_cats DESC, RAND()
            LIMIT ?
        ";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('iii', $gameId, $gameId, $limit);
        $stmt->execute();
        $games = [];
        $result = $stmt->get_result();
        while ($row = $result->fetch_assoc()) $games[] = $row;
        $stmt->close();
        foreach ($games as &$g) {
            $g['categories'] = $this->getCategoriesForGame($g['id']);
            $g['developer']  = $this->getStudioById($g['developer_id']);
            $g['publisher']  = $this->getStudioById($g['publisher_id']);
            $g['pegi'] = $this->getPegiById($g['pegi_id']);
}
        return $games;
    }

    private function getGamesByDeveloper(string $slug, int $limit = 10): array {
        $conn = $this->getConnection();
        $stmt = $conn->prepare("SELECT id, developer_id FROM {$this->table} WHERE slug = ?");
        $stmt->bind_param('s', $slug);
        $stmt->execute();
        $row = $stmt->get_result()->fetch_assoc();
        $stmt->close();
        if (!$row || !$row['developer_id']) return [];
        $gameId = (int)$row['id'];
        $developerId = (int)$row['developer_id'];

        $stmt = $conn->prepare(
            "SELECT * FROM {$this->table} WHERE developer_id = ? AND id != ? ORDER BY RAND() LIMIT ?"
        );
        $stmt->bind_param('iii', $developerId, $gameId, $limit);
        $stmt->execute();
        $games = [];
        $result = $stmt->get_result();
        while ($row = $result->fetch_assoc()) $games[] = $row;
        $stmt->close();
        foreach ($games as &$g) {
            $g['categories'] = $this->getCategoriesForGame($g['id']);
            $g['developer']  = $this->getStudioById($g['developer_id']);
            $g['publisher']  = $this->getStudioById($g['publisher_id']);
            $g['pegi'] = $this->getPegiById($g['pegi_id']);
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
            $game['pegi']    = $this->getPegiById($game['pegi_id']);
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
            $g['pegi'] = $this->getPegiById($g['pegi_id']);
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
            $g['pegi'] = $this->getPegiById($g['pegi_id']);
}

        // Most played
        $collections['most_played'] = $this->getMostPlayed($limit);

        return $collections;
    }
}
