<?php

// Clase del modelo para trabajar con la tabla PARTIDAS
class PartidaModel
{
    protected $url_apirest;
    private $id_partida;
    private $id_usuario;
    private $id_juego;
    private $fecha;
    private $tiempo;

    public function __construct() {
        $conf = Config::singleton();
        $this->url_apirest = $conf->get('url_apirest');
    }

    public function getAll() {
        session_start();
        $curl = curl_init($this->url_apirest. "partidas.php");
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
        $parametros = array('id_usuario' => $_REQUEST['id_usuario'], 'id_juego' => $_REQUEST['id_juego'], 'fecha' => $_REQUEST['fecha'], 'tiempo' => $_REQUEST['tiempo']);
        $ch = curl_init($this->url_apirest.'partidas.php');
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
        $ch = curl_init($this->url_apirest. "partidas.php?id_partida=". $id);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "DELETE");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('api-key: '.$_SESSION['token']));
        curl_exec($ch);
        curl_close($ch);
    }
}