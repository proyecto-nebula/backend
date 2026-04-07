<?php
/**
 * Clase para trabajar con la autentificación en la API
 * Hace uso de las clases implementadas en la carpeta "jwt" para realizar la autentificación mediante token
 * El token se genera a partir del id del usuario, por lo que cada usuario tendrá siempre un token distinto. 
 * Además del id, para generar el token se hace uso de una clave secreta que es un atributo de la clase
 */
require_once __DIR__ . '/../lib/jwt/JWT.php';
require_once __DIR__ . '/../models/authModel.php';
require_once __DIR__ . '/../utils/response.php';
use Firebase\JWT\JWT;

class Authentication extends AuthModel
{
    /**
     * Tabla donde estarán los usuarios (Ajustado a tu SQL: USUARIOS)
     */
    private $table = 'usuarios';

    /**
     * Clave secreta para realizar la encriptación y desencriptación del token
     */
    //private $key = 'clave_secreta_robusta_PROYECTO';
    private $key;
    private $authModel;

public function __construct() {

        // Asignación directa en una sola línea

        $this->key = getenv('JWT_SECRET');
        parent::__construct();

    }

    /**
     * Método para que un usuario se autentifique con un nombre de usuario y una contraseña
     */
    public function signIn($user)
    {
        if(!isset($user['alias']) || !isset($user['password']) || empty($user['alias']) || empty($user['password'])){
            $response = array(
                'result' => 'error',
                'details' => 'Los campos password y alias son obligatorios'
            );
            
            Response::result(400, $response);
            exit;
        }

        // Importante: En los datos random que insertamos, las contraseñas no tienen hash. 
        // Si vas a usar hash('sha256'...), asegúrate de que en la BD estén hasheadas.
        $result = parent::login($user['alias'], hash('sha256' , $user['password']));

        if(sizeof($result) == 0){
            $response = array(
                'result' => 'error',
                'details' => 'El alias y/o la contraseña son incorrectas'
            );

            Response::result(403, $response);
            exit;
        }

        // Ajustamos los índices a lo que devuelve tu SQL: id_usuario y nombre
        $dataToken = array(
            'iat' => time(),
            'data' => array(
                'id' => $result[0]['id_usuario'],
                'nombre' => $result[0]['alias']
            )
        );

        $jwt = JWT::encode($dataToken, $this->key);

        // Actualizamos el token en la base de datos usando el id_usuario
        parent::update($result[0]['id_usuario'], $jwt);

        return $jwt;
    }

    /**
     * Método para verificar si un token es válido cuando se realiza una petición a la API
     * El token se manda como header poniendo en name "api-key" y como value el valor del token
     */
    public function verify()
    {
        // Thunder Client envía los headers como HTTP_NOMBRE_DEL_HEADER
        if(!isset($_SERVER['HTTP_API_KEY'])){
    
            $response = array(
                'result' => 'error',
                'details' => 'Usted no tiene los permisos para esta solicitud (Falta API-KEY)'
            );
        
            Response::result(403, $response);
            exit;
        }

        $jwt = $_SERVER['HTTP_API_KEY'];

        try {
            $algorithms = array('HS256');
            $data = JWT::decode($jwt, $this->key, $algorithms);

            // Buscamos al usuario por el ID que viene dentro del token
            $user = parent::getById($data->data->id);

            // Verificamos que el token de la petición sea el mismo que el guardado en BD
            if(empty($user) || $user[0]['token'] != $jwt){
                throw new Exception();
            }
            
            return $data;
        } catch (\Throwable $th) {
            
            $response = array(
                'result' => 'error',
                'details' => 'Token inválido o expirado'
            );
        
            Response::result(403, $response);
            exit;
        }
    }
}