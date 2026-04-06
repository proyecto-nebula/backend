<?php
/**
 * Clase que hace de endpoint para la autentificación
 * Se debe mandar por POST un json con el usuario y la contraseña
 */
require_once __DIR__ . '/../src/classes/auth.class.php';
require_once __DIR__ . '/../src/utils/response.php';

$auth = new Authentication();

switch ($_SERVER['REQUEST_METHOD']) {
	case 'POST':
		$user = json_decode(file_get_contents('php://input'), true);

		$token = $auth->signIn($user);

		$response = array(
			'result' => 'ok',
			'token' => $token
		);

		Response::result(201, $response);

		break;
}