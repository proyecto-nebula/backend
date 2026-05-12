<?php

namespace App\Core;

use GuzzleHttp\Client;
use GuzzleHttp\Exception\GuzzleException;

/**
 * Servicio para consultar la API de IGDB (https://api.igdb.com).
 * El token OAuth de Twitch se cachea en disco para no pedirlo en cada llamada.
 */
class IgdbService
{
    private string $clientId;
    private string $clientSecret;
    private string $tokenFile;
    private Client $http;

    public function __construct()
    {
        $this->clientId     = (string) getenv('IGDB_CLIENT_ID');
        $this->clientSecret = (string) getenv('IGDB_CLIENT_SECRET');
        $this->tokenFile    = sys_get_temp_dir() . '/igdb_token.json';
        $this->http         = new Client(['timeout' => 10]);
    }

    /**
     * Devuelve el access_token de Twitch, usando la caché si sigue vigente.
     */
    private function getToken(): string
    {
        if (file_exists($this->tokenFile)) {
            $cached = json_decode((string) file_get_contents($this->tokenFile), true);
            if (isset($cached['access_token'], $cached['expires_at']) && time() < (int) $cached['expires_at']) {
                return (string) $cached['access_token'];
            }
        }

        $response = $this->http->post('https://id.twitch.tv/oauth2/token', [
            'query' => [
                'client_id'     => $this->clientId,
                'client_secret' => $this->clientSecret,
                'grant_type'    => 'client_credentials',
            ],
        ]);

        $body      = json_decode((string) $response->getBody(), true);
        $token     = (string) ($body['access_token'] ?? '');
        $expiresIn = (int)   ($body['expires_in']    ?? 3600);

        // Guardar con margen de 60 s
        file_put_contents($this->tokenFile, json_encode([
            'access_token' => $token,
            'expires_at'   => time() + $expiresIn - 60,
        ]));

        return $token;
    }

    /**
     * Devuelve un array de objetos ['image_url' => '...'] para el juego IGDB indicado.
     * @return array<int, array{image_url: string}>
     */
    public function getScreenshots(int $igdbId, int $limit = 15): array
    {
        if (empty($this->clientId) || empty($this->clientSecret)) {
            return [];
        }

        try {
            $token = $this->getToken();

            $response = $this->http->post('https://api.igdb.com/v4/screenshots', [
                'headers' => [
                    'Client-ID'     => $this->clientId,
                    'Authorization' => 'Bearer ' . $token,
                    'Accept'        => 'application/json',
                ],
                'body' => "fields image_id; where game = {$igdbId}; limit {$limit};",
            ]);

            $items = json_decode((string) $response->getBody(), true);

            if (!is_array($items)) {
                return [];
            }

            $screenshots = [];
            foreach ($items as $item) {
                if (!empty($item['image_id'])) {
                    $screenshots[] = [
                        'thumb_url' => "https://images.igdb.com/igdb/image/upload/t_screenshot_med/{$item['image_id']}.jpg",
                        'image_url' => "https://images.igdb.com/igdb/image/upload/t_1080p/{$item['image_id']}.jpg",
                    ];
                }
            }

            return $screenshots;

        } catch (GuzzleException $e) {
            error_log('[IgdbService] Error: ' . $e->getMessage());
            return [];
        }
    }

    /**
     * Devuelve un mapa igdb_id => [ { image_url } ] para varios igdb_id (batch).
     * Limit fijo por juego (default 10).
     * @param int[] $igdbIds
     * @return array<int, array{image_url: string}>
     */
    public function getScreenshotsForGames(array $igdbIds, int $limit = 10): array
    {
        if (empty($this->clientId) || empty($this->clientSecret)) {
            return [];
        }

        $ids = array_values(array_filter(array_map('intval', $igdbIds)));
        if (count($ids) === 0) return [];

        // Evitar peticiones enormes
        $maxGames = 25;
        if (count($ids) > $maxGames) {
            $ids = array_slice($ids, 0, $maxGames);
        }

        $requestedRows = min(500, count($ids) * $limit);
        $idsList = implode(',', $ids);

        try {
            $token = $this->getToken();
            $response = $this->http->post('https://api.igdb.com/v4/screenshots', [
                'headers' => [
                    'Client-ID'     => $this->clientId,
                    'Authorization' => 'Bearer ' . $token,
                    'Accept'        => 'application/json',
                ],
                'body' => "fields image_id, game; where game = ({$idsList}); limit {$requestedRows};",
            ]);

            $items = json_decode((string) $response->getBody(), true);
            if (!is_array($items)) return [];

            $map = [];
            foreach ($items as $it) {
                if (empty($it['image_id']) || empty($it['game'])) continue;
                $g = (int)$it['game'];
                $map[$g][] = [
                    'thumb_url' => "https://images.igdb.com/igdb/image/upload/t_screenshot_med/{$it['image_id']}.jpg",
                    'image_url' => "https://images.igdb.com/igdb/image/upload/t_1080p/{$it['image_id']}.jpg",
                ];
            }

            foreach ($map as $g => $arr) {
                $map[$g] = array_slice($arr, 0, $limit);
            }

            return $map;
        } catch (GuzzleException $e) {
            error_log('[IgdbService] getScreenshotsForGames error: ' . $e->getMessage());
            return [];
        }
    }
}
