<?php
namespace App\Classes;

use App\Core\IgdbService;
use App\Models\Database;
use App\Utils\Response;

/**
 * Obtiene screenshots desde la API de IGDB usando el igdb_id del juego.
 * Requiere `id` (id del juego en nuestra BD) como parámetro de ruta.
 */
class Screenshots extends Database
{
    /**
     * GET /api/v1/screenshots/{id}
     * Devuelve array de { imageUrl } para el juego indicado.
     */
    public function get(array $params): array
    {
        $gameId = isset($params['id']) ? (int) $params['id'] : null;

        if (!$gameId) {
            Response::error('El parámetro id es obligatorio', 400);
            exit;
        }

        // Obtener igdb_id desde la tabla games
        $conn = $this->getConnection();
        $stmt = $conn->prepare('SELECT igdb_id FROM games WHERE id = ? AND is_active = 1 LIMIT 1');

        if ($stmt === false) {
            return [];
        }

        $stmt->bind_param('i', $gameId);
        $stmt->execute();
        $result = $stmt->get_result();
        $game   = $result->fetch_assoc();
        $stmt->close();

        if (!$game) {
            Response::error('Juego no encontrado', 404);
            exit;
        }

        if (empty($game['igdb_id'])) {
            Response::error('El juego no tiene igdb_id', 422);
            exit;
        }

        $igdbService = new IgdbService();
        return $igdbService->getScreenshots((int) $game['igdb_id']);
    }
}