<?php

// Clase del modelo para trabajar con la tabla ESTUDIOS
class EstudioModel
{
    protected $url_apirest;
    private $id_estudio;
    private $nombre;
    private $logo;

    public function __construct() {
        $conf = Config::singleton();
        $this->url_apirest = $conf->get('url_apirest');
    }

    public function getIdEstudio() { return $this->id_estudio; }
    public function setIdEstudio($id) { $this->id_estudio = $id; }
    public function getNombre() { return $this->nombre; }
    public function setNombre($nombre) { $this->nombre = $nombre; }

    public function getAll() {
        session_start();
        $curl = curl_init($this->url_apirest. "estudios.php");
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_HTTPHEADER, array('api-key: '.$_SESSION['token']));
        $data = curl_exec($curl);
        curl_close($curl);
        $array_respuesta = json_decode($data, true);
        $array_datos = isset($array_respuesta['items']) ? $array_respuesta['items'] : array();
        $models = array();
        foreach ($array_datos as $datos) {
            $m = new EstudioModel();
            $m->setIdEstudio($datos['id_estudio']);
            $m->setNombre($datos['nombre']);
            $models[] = $m;
        }
        return $models;
    }

    public function insert(){
        session_start();
        $parametros = array('nombre' => $_REQUEST['nombre'], 'logo' => $_REQUEST['logo']);
        $ch = curl_init($this->url_apirest.'estudios.php');
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
        $ch = curl_init($this->url_apirest. "estudios.php?id_estudio=". $id);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "PUT");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($_REQUEST));
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json', 'api-key: '.$_SESSION['token']));
        curl_exec($ch);
        curl_close($ch);
    }

    public function delete($id){
        session_start();
        $ch = curl_init($this->url_apirest. "estudios.php?id_estudio=". $id);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "DELETE");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('api-key: '.$_SESSION['token']));
        curl_exec($ch);
        curl_close($ch);
    }
}