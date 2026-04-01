<?php

// Clase del modelo para trabajar con la tabla CAPTURAS
class CapturaModel
{
    protected $url_apirest;
    private $id_captura;
    private $id_juego;
    private $imagen;

    public function __construct() {
        $conf = Config::singleton();
        $this->url_apirest = $conf->get('url_apirest');
    }

    public function getAll() {
        session_start();
        $curl = curl_init($this->url_apirest. "capturas.php");
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_HTTPHEADER, array('api-key: '.$_SESSION['token']));
        $data = curl_exec($curl);
        curl_close($curl);
        $array_respuesta = json_decode($data, true);
        return isset($array_respuesta['items']) ? $array_respuesta['items'] : array();
    }

    public function insert(){
        session_start();
        $parametros = array('id_juego' => $_REQUEST['id_juego'], 'imagen' => $_REQUEST['imagen']);
        $ch = curl_init($this->url_apirest.'capturas.php');
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json', 'api-key: '.$_SESSION['token']));
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($parametros));
        $response = curl_exec($ch);
        curl_close($ch);
        echo $response;
    }

    public function delete($id){
        session_start();
        $ch = curl_init($this->url_apirest. "capturas.php?id_captura=". $id);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "DELETE");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('api-key: '.$_SESSION['token']));
        curl_exec($ch);
        curl_close($ch);
    }
}