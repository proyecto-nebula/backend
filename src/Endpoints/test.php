<?php
// endpoints/test.php
header('Content-Type: application/json; charset=utf-8');
echo json_encode([
    'status' => 'success',
    'message' => 'El Router MVC funciona correctamente'
]);
exit;
