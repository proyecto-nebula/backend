<?php

// Clase del modelo para trabajar con la tabla PAIS
class PaisModel
{
    protected $url_apirest;
    private $id_pais;
    private $nombre;
    private $bandera;

    public function __construct() {
        $conf = Config::singleton();
        $this->url_apirest = $conf->get('url_apirest');
    }

    public function getIdPais() { return $this->id_pais; }
    public function setIdPais($id) { $this->id_pais = $id; }

    public function getAll() {
        session_start();
        $curl = curl_init($this->url_apirest. "pais.php");
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_HTTPHEADER, array('api-key: '.$_SESSION['token']));
        $data = curl_exec($curl);
        curl_close($curl);
        $array_respuesta = json_decode($data, true);
        $array_datos = isset($array_respuesta['items']) ? $array_respuesta['items'] : array();
        $models = array();
        foreach ($array_datos as $datos) {
            $m = new PaisModel();
            $m->setIdPais($datos['id_pais']);
            $m->nombre = $datos['nombre'];
            $models[] = $m;
        }
        return $models;
    }

    public function insert(){
        session_start();
        $ch = curl_init($this->url_apirest.'pais.php');
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json', 'api-key: '.$_SESSION['token']));
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($_REQUEST));
        $response = curl_exec($ch);
        curl_close($ch);
        echo $response;
    }

    public function delete($id){
        session_start();
        $ch = curl_init($this->url_apirest. "pais.php?id_pais=". $id);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "DELETE");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('api-key: '.$_SESSION['token']));
        curl_exec($ch);
        curl_close($ch);
    }
}