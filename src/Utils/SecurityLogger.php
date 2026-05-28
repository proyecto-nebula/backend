<?php

namespace App\Utils;

/**
 * Logger de eventos de seguridad — escribe en storage/logs/security.log.
 * Cada línea es un objeto JSON (newline-delimited JSON).
 */
class SecurityLogger
{
    private static string $logFile = '';

    private static function logPath(): string
    {
        if (self::$logFile === '') {
            $dir = realpath(__DIR__ . '/../../') . DIRECTORY_SEPARATOR . 'storage' . DIRECTORY_SEPARATOR . 'logs';
            if (!is_dir($dir)) {
                mkdir($dir, 0750, true);
            }
            self::$logFile = $dir . DIRECTORY_SEPARATOR . 'security.log';
        }
        return self::$logFile;
    }

    public static function log(string $event, array $context = []): void
    {
        $entry = array_merge([
            'timestamp' => date('Y-m-d H:i:s'),
            'event'     => $event,
            'ip'        => $_SERVER['REMOTE_ADDR'] ?? 'unknown',
            'ua'        => mb_substr($_SERVER['HTTP_USER_AGENT'] ?? '', 0, 150),
        ], $context);

        $line = json_encode($entry, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) . PHP_EOL;
        $path = self::logPath();

        $fp = fopen($path, 'a');
        if ($fp) {
            flock($fp, LOCK_EX);
            fwrite($fp, $line);
            flock($fp, LOCK_UN);
            fclose($fp);
        }
    }

    /** Devuelve las últimas $limit líneas en orden inverso (más recientes primero). */
    public static function read(int $limit = 300): array
    {
        $path = self::logPath();
        if (!file_exists($path)) {
            return [];
        }
        $lines = file($path, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
        if ($lines === false) {
            return [];
        }
        $lines = array_slice(array_reverse($lines), 0, $limit);
        return array_map(fn($l) => json_decode($l, true) ?? ['raw' => $l], $lines);
    }

    public static function clear(): void
    {
        $path = self::logPath();
        if (file_exists($path)) {
            file_put_contents($path, '');
        }
    }
}
