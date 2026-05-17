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

    /**
     * Devuelve datos extra de IGDB para un juego: modos, motores, perspectivas,
     * puntuación, videos y websites.
     *
     * @return array{
     *   game_modes: string[],
     *   game_engines: string[],
     *   multiplayer_modes: string[],
     *   player_perspectives: string[],
     *   total_rating: float|null,
     *   videos: array<int, array{video_id:string, url:string, embed_url:string}>,
     *   websites: array<int, array{url:string, type:int}>
     * }
     */
    public function getGameDetails(int $igdbId): array
    {
        $empty = [
            'game_modes'          => [],
            'game_engines'        => [],
            'multiplayer_modes'   => [],
            'player_perspectives' => [],
            'total_rating'        => null,
            'videos'              => [],
            'websites'            => [],
        ];

        if (empty($this->clientId) || empty($this->clientSecret)) {
            return $empty;
        }

        try {
            $token = $this->getToken();

            $fields = implode(',', [
                'game_modes.name',
                'game_engines.name',
                'multiplayer_modes.offlinecoop',
                'multiplayer_modes.onlinecoop',
                'multiplayer_modes.splitscreen',
                'multiplayer_modes.lancoop',
                'multiplayer_modes.campaigncoop',
                'multiplayer_modes.dropin',
                'player_perspectives.name',
                'total_rating',
                'videos.video_id',
                'videos.name',
                'websites.url',
                'websites.type',
            ]);

            $response = $this->http->post('https://api.igdb.com/v4/games', [
                'headers' => [
                    'Client-ID'     => $this->clientId,
                    'Authorization' => 'Bearer ' . $token,
                    'Accept'        => 'application/json',
                ],
                'body' => "fields {$fields}; where id = {$igdbId}; limit 1;",
            ]);

            $items = json_decode((string) $response->getBody(), true);

            if (!is_array($items) || count($items) === 0) {
                return $empty;
            }

            $d = $items[0];

            // game_modes → names
            $gameModes = [];
            foreach ($d['game_modes'] ?? [] as $m) {
                if (!empty($m['name'])) $gameModes[] = $m['name'];
            }

            // game_engines → names
            $gameEngines = [];
            foreach ($d['game_engines'] ?? [] as $e) {
                if (!empty($e['name'])) $gameEngines[] = $e['name'];
            }

            // multiplayer_modes → derive labels from boolean flags (deduplicated)
            $mpLabels = [
                'offlinecoop'  => 'Co-op offline',
                'onlinecoop'   => 'Co-op online',
                'splitscreen'  => 'Pantalla dividida',
                'lancoop'      => 'Co-op LAN',
                'campaigncoop' => 'Campaña co-op',
                'dropin'       => 'Drop-in/out',
            ];
            $multiplayerModes = [];
            foreach ($d['multiplayer_modes'] ?? [] as $mm) {
                foreach ($mpLabels as $flag => $label) {
                    if (!empty($mm[$flag]) && !in_array($label, $multiplayerModes, true)) {
                        $multiplayerModes[] = $label;
                    }
                }
            }

            // player_perspectives → names
            $playerPerspectives = [];
            foreach ($d['player_perspectives'] ?? [] as $pp) {
                if (!empty($pp['name'])) $playerPerspectives[] = $pp['name'];
            }

            // videos → YouTube URLs
            $videos = [];
            foreach ($d['videos'] ?? [] as $v) {
                if (!empty($v['video_id'])) {
                    $vid = $v['video_id'];
                    $videos[] = [
                        'video_id'  => $vid,
                        'name'      => $v['name'] ?? '',
                        'url'       => "https://www.youtube.com/watch?v={$vid}",
                        'embed_url' => "https://www.youtube.com/embed/{$vid}",
                    ];
                }
            }

            // websites → url + type
            $websites = [];
            foreach ($d['websites'] ?? [] as $site) {
                if (!empty($site['url'])) {
                    $websites[] = [
                        'url'  => $site['url'],
                        'type' => (int) ($site['type'] ?? 0),
                    ];
                }
            }
            usort($websites, fn($a, $b) => $a['type'] <=> $b['type']);

            return [
                'game_modes'          => $gameModes,
                'game_engines'        => $gameEngines,
                'multiplayer_modes'   => $multiplayerModes,
                'player_perspectives' => $playerPerspectives,
                'total_rating'        => isset($d['total_rating']) ? round((float) $d['total_rating'], 1) : null,
                'videos'              => $videos,
                'websites'            => $websites,
            ];

        } catch (GuzzleException $e) {
            error_log('[IgdbService] getGameDetails error: ' . $e->getMessage());
            return $empty;
        }
    }
}
