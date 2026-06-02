<?php
/**
 * Endpoint de autenticación.
 * POST   /api/v1/auth                        → login (devuelve JWT + establece cookie HttpOnly)
 * POST   /api/v1/auth/validate-password      → validar contraseña del usuario autenticado
 * GET    /api/v1/auth                        → perfil del usuario autenticado (vía cookie)
 * DELETE /api/v1/auth                        → logout (borra cookie)
 */
$auth = new \App\Classes\Authentication();

switch ($_SERVER['REQUEST_METHOD']) {
    case 'POST':
        // Validar contraseña antigua (para cambios de contraseña)
        if (isset($_GET['id']) && $_GET['id'] === 'validate-password') {
            try {
                $tokenData = $auth->getMe();
                $data = json_decode(file_get_contents('php://input'), true);

                if (!isset($data['userId']) || !isset($data['password'])) {
                    \App\Utils\Response::result(400, ['result' => 'error', 'details' => 'userId y password son obligatorios']);
                    exit;
                }

                if ($data['userId'] !== $tokenData['id']) {
                    \App\Utils\Response::error('No autorizado para validar contraseña de otro usuario', 403);
                    exit;
                }

                $users = new \App\Classes\Users();
                $userData = $users->getPerfilCompleto($tokenData['id']);

                if (!$userData) {
                    \App\Utils\Response::error('Usuario no encontrado', 404);
                    exit;
                }

                // Comparar contraseña
                $hashedPassword = hash('sha256', $data['password']);
                $isValid = $hashedPassword === $userData['password'];

                \App\Utils\Response::ok(['valid' => $isValid], 200);
            } catch (\Throwable $e) {
                \App\Utils\Response::error('Error validando contraseña: ' . $e->getMessage(), 500);
            }
            break;
        }

        // Login normal
        $user  = json_decode(file_get_contents('php://input'), true);
        $token = $auth->signIn($user);
        // El token también se devuelve en el body por compatibilidad con clientes API
        \App\Utils\Response::ok(['token' => $token], 201);
        break;

    case 'GET':
        try {
            $tokenData = $auth->getMe();
            $users     = new \App\Classes\Users();
            $userData  = $users->getPerfilCompleto($tokenData['id']);
            if ($userData) {
                \App\Utils\Response::ok($userData);
            } else {
                \App\Utils\Response::error('Usuario no encontrado', 404);
            }
        } catch (\Throwable $e) {
            \App\Utils\Response::error('No autenticado', 401);
        }
        break;

    case 'DELETE':
        $auth->logout();
        \App\Utils\Response::ok();
        break;

    default:
        header('Allow: GET, POST, DELETE');
        \App\Utils\Response::error('Método no permitido', 405);
        break;
}