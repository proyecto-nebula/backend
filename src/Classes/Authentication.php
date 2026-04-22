<?php

namespace App\Classes;

use App\Core\JwtService;
use App\Models\AuthModel;
use App\Utils\Response;

class Authentication extends AuthModel
{
    private $key;
    private $jwtService;

    public function __construct()
    {
        $this->key = getenv('JWT_SECRET');
        parent::__construct();
        $this->jwtService = new JwtService((string) $this->key);
    }

    /**
     * Método para que un usuario se autentifique con un nombre de usuario y una contraseña
     */
    public function signIn($user)
    {
        if(!isset($user['email']) || !isset($user['password']) || empty($user['email']) || empty($user['password'])){
            $response = array(
                'result' => 'error',
                'details' => 'Los campos password y el email son obligatorios'
            );
            
            Response::result(400, $response);
            exit;
        }

        // Importante: En los datos random que insertamos, las contraseñas no tienen hash. 
        // Si vas a usar hash('sha256'...), asegúrate de que en la BD estén hasheadas.
        $result = parent::login($user['email'], hash('sha256' , $user['password']));

        if(sizeof($result) == 0){
            $response = array(
                'result' => 'error',
                'details' => 'El email y/o la contraseña son incorrectas'
            );

            Response::result(403, $response);
            exit;
        }

        $dataToken = array(
            'iat' => time(),
            'data' => array(
                'id' => $result[0]['id'],
                'email' => $result[0]['email']
            )
        );

        $jwt = $this->jwtService->encode($dataToken);

        parent::update($result[0]['id'], $jwt);

        return $jwt;
    }

    public function validateToken(string $jwt): array
    {
        $payload = $this->jwtService->decode($jwt);
        $claimData = $payload['data'] ?? [];
        if (!is_array($claimData) || !isset($claimData['id'])) {
            throw new \Exception('Invalid claims');
        }

        $user = parent::getById($claimData['id']);
        if (empty($user) || $user[0]['token'] != $jwt) {
            throw new \Exception('Token mismatch');
        }

        return [
            'id' => (string) $claimData['id'],
            'email' => (string) ($claimData['email'] ?? '')
        ];
    }
}