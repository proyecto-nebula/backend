<?php
/**
 * Clase que hace de endpoint para la autentificación
 * Se debe mandar por POST un json con el usuario y la contraseña
 */
$auth = new \App\Classes\Authentication();

switch ($_SERVER['REQUEST_METHOD']) {
    case 'POST':
        $user = json_decode(file_get_contents('php://input'), true);
        $token = $auth->signIn($user);
        \App\Utils\Response::ok(['token' => $token], 201);
        break;

    default:
        header('Allow: POST');
        \App\Utils\Response::error('Método no permitido', 405);
        break;
}