<?php
// Clase del modelo para trabajar con objetos usuario que se almacenan en BD en la tabla usuario
class UsuarioModel
{
    // Conexión a la BD
    protected $url_apirest;

    // Atributos del objeto usuario que coinciden con los campos de la tabla usuario
    private $username;
    private $password;
    private $nombres;
    private $disponible;


    // Constructor que utiliza el patrón Singleton para tener una única instancia de la conexión a BD
    public function __construct()
    {
        $conf = Config::singleton();
        $this->url_apirest = $conf->get('url_apirest');
    }

    // Getters y Setters
    public function getLogin()
    {
        return $this->username;
    }
    public function setLogin($login)
    {
        return $this->username = $login;
    }

    public function getPassword()
    {
        return $this->password;
    }
    public function setPassword($password)
    {
        return $this->password = $password;
    }

    public function getName()
    {
        return $this->nombres;
    }
    public function setName($name)
    {
        return $this->nombres = $name;
    }

    public function getActive()
    {
        return $this->disponible;
    }
    public function setActive($active)
    {
        return $this->disponible = $active;
    }


    // Método para autenticar a un usuario
    public function autenticar($login,$password): string
    {
        $parametros = array(
            'username' => $login,
            'password' => $password
        );

        $params_json = json_encode($parametros);

        // Se hace la llamada POST a la API
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $this->url_apirest. "auth.php");
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

        $headers = array(
            'Content-Type' => 'application/json; charset=UTF-8'
        );

        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $params_json);

        $response = curl_exec($ch);
        curl_close($ch);

        if ($response === false) {
            $resultado = "Error";
        } else {
            $array_resultado = json_decode($response, true);

            if ($array_resultado['result'] == 'error') {
               $resultado="Error";
            } else {
                // Guardamos el token
                $resultado = $array_resultado['token'];
            }
        }

        return $resultado;
    }



}
