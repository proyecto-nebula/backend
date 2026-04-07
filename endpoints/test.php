<?php
// endpoints/test.php
header('Content-Type: application/json');
echo json_encode([
    'status' => 'success',
    'message' => 'El Router MVC funciona correctamente'
]);
exit;
