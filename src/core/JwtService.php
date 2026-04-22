<?php

namespace App\Core;

final class JwtService
{
    public function __construct(private readonly string $secret)
    {
        if ($this->secret === '') {
            throw new \InvalidArgumentException('JWT secret is required');
        }
    }

    public function encode(array $payload): string
    {
        $header = [
            'typ' => 'JWT',
            'alg' => 'HS256',
        ];

        $encodedHeader = $this->base64UrlEncode($this->jsonEncode($header));
        $encodedPayload = $this->base64UrlEncode($this->jsonEncode($payload));
        $signature = $this->sign($encodedHeader . '.' . $encodedPayload);

        return $encodedHeader . '.' . $encodedPayload . '.' . $signature;
    }

    public function decode(string $jwt): array
    {
        $parts = explode('.', $jwt);
        if (count($parts) !== 3) {
            throw new \InvalidArgumentException('Invalid token structure');
        }

        [$encodedHeader, $encodedPayload, $providedSignature] = $parts;

        $header = $this->jsonDecode($this->base64UrlDecode($encodedHeader));
        if (($header['alg'] ?? null) !== 'HS256') {
            throw new \InvalidArgumentException('Unsupported token algorithm');
        }

        $expectedSignature = $this->sign($encodedHeader . '.' . $encodedPayload);
        if (!hash_equals($expectedSignature, $providedSignature)) {
            throw new \InvalidArgumentException('Invalid token signature');
        }

        $payload = $this->jsonDecode($this->base64UrlDecode($encodedPayload));
        if (!is_array($payload)) {
            throw new \InvalidArgumentException('Invalid token payload');
        }

        return $payload;
    }

    private function sign(string $message): string
    {
        return $this->base64UrlEncode(hash_hmac('sha256', $message, $this->secret, true));
    }

    private function jsonEncode(array $data): string
    {
        return json_encode($data, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE | JSON_THROW_ON_ERROR);
    }

    private function jsonDecode(string $data): array
    {
        $decoded = json_decode($data, true, 512, JSON_THROW_ON_ERROR);
        if (!is_array($decoded)) {
            throw new \InvalidArgumentException('Invalid JSON payload');
        }

        return $decoded;
    }

    private function base64UrlEncode(string $data): string
    {
        return rtrim(strtr(base64_encode($data), '+/', '-_'), '=');
    }

    private function base64UrlDecode(string $data): string
    {
        $padding = strlen($data) % 4;
        if ($padding > 0) {
            $data .= str_repeat('=', 4 - $padding);
        }

        $decoded = base64_decode(strtr($data, '-_', '+/'), true);
        if ($decoded === false) {
            throw new \InvalidArgumentException('Invalid base64 payload');
        }

        return $decoded;
    }
}