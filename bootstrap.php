<?php

require_once __DIR__ . '/vendor/autoload.php';

// Normalize APP_ENV so short values like "prod" are treated as "production".
$rawAppEnv = getenv('APP_ENV') ?: '';
$normalized = strtolower(trim($rawAppEnv));
if ($normalized === 'prod') {
	putenv('APP_ENV=production');
	$_ENV['APP_ENV'] = 'production';
	$_SERVER['APP_ENV'] = 'production';
}
