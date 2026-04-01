<?php

// Clase del modelo para trabajar con objetos Item que se almacenan en BD en la tabla ITEMS
class ItemModel
{
    // Conexión a la BD
    protected $url_apirest;

    // Atributos del objeto item que coinciden con los campos de la tabla ITEMS
    private $codigo;
    private $nombre;

    // Constructor que utiliza el patrón Singleton para tener una única instancia de la conexión a BD
    public function __construct()
    {
        $conf = Config::singleton();
        $this->url_apirest = $conf->get('url_apirest');
    }

    // Getters y Setters
    public function getCodigo()
    {
        return $this->codigo;
    }
    public function setCodigo($codigo)
    {
        return $this->codigo = $codigo;
    }

    public function getNombre()
    {
        return $this->nombre;
    }
    public function setNombre($nombre)
    {
        return $this->nombre = $nombre;
    }

    // Método para obtener todos los registros de la tabla ITEMS
    // Devuelve un array de objetos de la clase ItemModel
    public function getAll()
    {
        session_start();

        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $this -> url_apirest. "item.php");
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);

        $headers = array(
            'Content-Type: application/json; charset=UTF-8',
            'api-key: '.$_SESSION['token']
        );

        curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
        $data = curl_exec($curl);
        curl_close($curl);

        $array_respuesta = json_decode($data, true);
        $array_datos = array();

        if (isset($array_respuesta['items'])) {
            $array_datos = $array_respuesta['items'];
        }

        $itemModels = array();
        foreach ($array_datos as $datos) {
            $itemModel = new ItemModel();
            $itemModel->setCodigo($datos['codigo']);
            $itemModel->setNombre($datos['nombre']);
            $itemModels[] = $itemModel;
        }

        return $itemModels;
    }


    // Método que devuelve (si existe en BD) un objeto ItemModel con un código determinado
    public function getById($codigo)
    {
        session_start();

        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $this -> url_apirest. "item.php?codigo=". $codigo);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
    
        $headers = array(
            'Content-Type: application/json; charset=UTF-8',
            'api-key: '.$_SESSION['token']
        );
    
        curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
        $data = curl_exec($curl);
        curl_close($curl);
    
        $array_respuesta = json_decode($data, true);
        $array_datos = array();

        if (isset($array_respuesta['items'])) {
            $array_datos = $array_respuesta['items'];
        }
            
        $itemModel = null;
        if (count($array_datos) > 0) {
            $datos = $array_datos[0];
            $itemModel = new ItemModel();
            $itemModel->setCodigo($datos['codigo']);
            $itemModel->setNombre($datos['nombre']);
        }
    
        return $itemModel;
    }
        
    
 
      
    

    // Método para insertar un nuevo ItemModel en la BD
    public function insert(){

        session_start();

        $parametros = array(
            'nombre' => $_REQUEST['nombre']
        );

        $params_json = json_encode($parametros);

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $this -> url_apirest.'item.php');
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

        $headers = array(
            'Content-Type: application/json; charset=UTF-8',
            'api-key: '.$_SESSION['token']
        );
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

        curl_setopt($ch, CURLOPT_POSTFIELDS, $params_json);
        $response = curl_exec($ch);
        curl_close($ch);
        echo $response;
    }

    //Método para actualizar un item
    public function update($codigo){

        session_start();
        $parametros = array(
            'nombre' => $_REQUEST['nombre']
        );

        $params_json = json_encode($parametros);
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $this -> url_apirest. "item.php?codigo=". $codigo);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "PUT");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $params_json); // Agrega los parámetros de la solicitud
        $headers = array(
            'Content-Type: application/json; charset=UTF-8',
            'api-key: '.$_SESSION['token']
        );
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

        $response = curl_exec($ch); // Envía la solicitud

        if (!$response) {
            die('Error: "' . curl_error($ch) . '" - Code: ' . curl_errno($ch));
        }
        curl_close($ch);
    }

    //Método para borrar un item
    public function delete($codigo){

        session_start();
    
        $ch = curl_init();

        curl_setopt($ch, CURLOPT_URL, $this -> url_apirest. "item.php?codigo=". $codigo);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "DELETE");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        
        $headers = array(
            'Content-Type: application/json; charset=UTF-8',
            'api-key: '.$_SESSION['token']

        );
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_exec($ch);
        curl_close($ch);
    }
}