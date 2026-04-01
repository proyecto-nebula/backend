<?php

// Clase del modelo para trabajar con la tabla CATEGORIAS
class CategoriaModel
{
    protected $url_apirest;
    private $id_categoria;
    private $nombre;

    public function __construct() {
        $conf = Config::singleton();
        $this->url_apirest = $conf->get('url_apirest');
    }

    public function getIdCategoria() { return $this->id_categoria; }
    public function setIdCategoria($id) { $this->id_categoria = $id; }
    public function getNombre() { return $this->nombre; }
    public function setNombre($nombre) { $this->nombre = $nombre; }

    public function getAll() {
        session_start();
        $curl = curl_init($this->url_apirest. "categorias.php");
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_HTTPHEADER, array('api-key: '.$_SESSION['token']));
        $data = curl_exec($curl);
        curl_close($curl);
        $array_respuesta = json_decode($data, true);
        $array_datos = isset($array_respuesta['items']) ? $array_respuesta['items'] : array();
        $models = array();
        foreach ($array_datos as $datos) {
            $m = new CategoriaModel();
            $m->setIdCategoria($datos['id_categoria']);
            $m->setNombre($datos['nombre']);
            $models[] = $m;
        }
        return $models;
    }

    public function getById($id) {
        session_start();
        $curl = curl_init($this->url_apirest. "categorias.php?id_categoria=". $id);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_HTTPHEADER, array('api-key: '.$_SESSION['token']));
        $data = curl_exec($curl);
        curl_close($curl);
        $array_respuesta = json_decode($data, true);
        $array_datos = isset($array_respuesta['items']) ? $array_respuesta['items'] : array();
        if (count($array_datos) > 0) {
            $m = new CategoriaModel();
            $m->setIdCategoria($array_datos[0]['id_categoria']);
            $m->setNombre($array_datos[0]['nombre']);
            return $m;
        }
        return null;
    }

    public function insert(){
        session_start();
        $parametros = array('nombre' => $_REQUEST['nombre']);
        $ch = curl_init($this->url_apirest.'categorias.php');
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json', 'api-key: '.$_SESSION['token']));
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($parametros));
        $response = curl_exec($ch);
        curl_close($ch);
        echo $response;
    }

    public function update($id){
        session_start();
        $ch = curl_init($this->url_apirest. "categorias.php?id_categoria=". $id);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "PUT");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode(array('nombre' => $_REQUEST['nombre'])));
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json', 'api-key: '.$_SESSION['token']));
        curl_exec($ch);
        curl_close($ch);
    }

    public function delete($id){
        session_start();
        $ch = curl_init($this->url_apirest. "categorias.php?id_categoria=". $id);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "DELETE");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('api-key: '.$_SESSION['token']));
        curl_exec($ch);
        curl_close($ch);
    }
}