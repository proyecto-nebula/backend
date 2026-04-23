<?php
namespace App\Utils;

/**
 * Clase estática que se utiliza para generar la respuesta que se envía al cliente que hace uso de la API REST.
 */
class Response
{
    public static function result($code, $response): void
    {
        if (self::isSuccessEnvelope($response)) {
            $payload = $response['data'] ?? null;
            if ($payload === null) {
                self::sendNoContent($code === 200 ? 204 : $code);
                return;
            }

            if (is_array($payload)) {
                $payload = self::convertKeysToCamelCase($payload);
            }

            header('Content-Type: application/json; charset=utf-8');
            http_response_code($code);
            echo json_encode($payload, JSON_UNESCAPED_UNICODE);
            return;
        }

        if (is_array($response)) {
            if (self::isErrorEnvelope($response)) {
                $response = self::normalizeErrorPayload($response, $code);
            }

            $response = self::convertKeysToCamelCase($response);
        }

        header('Content-Type: application/json; charset=utf-8');
        http_response_code($code);
        echo json_encode($response, JSON_UNESCAPED_UNICODE);
    }

    public static function ok($data = null, int $code = 200): void
    {
        self::result($code, [
            'result' => 'ok',
            'data' => $data,
        ]);
    }

    public static function error(string $message, int $code = 400, ?string $errorCode = null): void
    {
        self::result($code, [
            'result'  => 'error',
            'code'    => $errorCode ?? self::defaultErrorCode($code),
            'message' => $message,
        ]);
    }

    private static function isSuccessEnvelope($response): bool
    {
        return is_array($response) && (($response['result'] ?? null) === 'ok') && array_key_exists('data', $response);
    }

    private static function isErrorEnvelope($response): bool
    {
        return is_array($response) && (
            (($response['result'] ?? null) === 'error') ||
            isset($response['details']) ||
            isset($response['message']) ||
            isset($response['error'])
        );
    }

    private static function normalizeErrorPayload(array $response, int $statusCode): array
    {
        $message = $response['message'] ?? $response['details'] ?? $response['error'] ?? 'Error inesperado';
        $errorCode = $response['code'] ?? self::defaultErrorCode($statusCode);

        return [
            'code' => (string) $errorCode,
            'message' => (string) $message,
        ];
    }

    private static function defaultErrorCode(int $statusCode): string
    {
        return match ($statusCode) {
            400 => 'VALIDATION_ERROR',
            401 => 'UNAUTHORIZED',
            403 => 'FORBIDDEN',
            404 => 'NOT_FOUND',
            405 => 'METHOD_NOT_ALLOWED',
            409 => 'CONFLICT',
            422 => 'UNPROCESSABLE_ENTITY',
            500 => 'INTERNAL_SERVER_ERROR',
            default => 'API_ERROR',
        };
    }

    private static function sendNoContent(int $code): void
    {
        http_response_code($code);
        return;
    }

    private static function convertKeysToCamelCase(array $value): array
    {
        if (!self::isAssoc($value)) {
            foreach ($value as $index => $item) {
                if (is_array($item)) {
                    $value[$index] = self::convertKeysToCamelCase($item);
                }
            }

            return $value;
        }

        $converted = [];
        foreach ($value as $key => $item) {
            $newKey = is_string($key) ? self::toCamelCase($key) : $key;
            if (is_array($item)) {
                $converted[$newKey] = self::convertKeysToCamelCase($item);
            } else {
                $converted[$newKey] = $item;
            }
        }

        return $converted;
    }

    private static function toCamelCase(string $key): string
    {
        $camel = preg_replace_callback('/_([a-z])/', static function (array $matches): string {
            return strtoupper($matches[1]);
        }, $key) ?? $key;

        return self::applyAcronymRules($camel);
    }

    private static function applyAcronymRules(string $key): string
    {
        if ($key === 'id') {
            return 'ID';
        }

        if ($key === 'url') {
            return 'URL';
        }

        $key = preg_replace('/Id\b/', 'ID', $key) ?? $key;
        $key = preg_replace('/Url\b/', 'URL', $key) ?? $key;

        return $key;
    }

    private static function isAssoc(array $array): bool
    {
        return array_keys($array) !== range(0, count($array) - 1);
    }
}
