<?php

// Clase del modelo para trabajar con objetos Juego de la tabla JUEGOS
class JuegoModel
{
    protected $url_apirest;

    private $id_juego;
    private $id_desarrollador;
    private $id_distribuidor;
    private $id_pegi;
    private $titulo;
    private $descripcion_corta;
    private $descripcion_larga;

    public function __construct()
    {
        $conf = Config::singleton();
        $this->url_apirest = $conf->get('url_apirest');
    }

    public function getIdJuego() { return $this->id_juego; }
    public function setIdJuego($id_juego) { $this->id_juego = $id_juego; }
    public function getTitulo() { return $this->titulo; }
    public function setTitulo($titulo) { $this->titulo = $titulo; }

    public function getAll()
    {
        session_start();
        $curl = curl_init($this->url_apirest. "juegos.php");
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_HTTPHEADER, array('api-key: '.$_SESSION['token']));
        $data = curl_exec($curl);
 
        $array_respuesta = json_decode($data, true);
        $array_datos = isset($array_respuesta['items']) ? $array_respuesta['items'] : array();
        $models = array();
        foreach ($array_datos as $datos) {
            $m = new JuegoModel();
            $m->setIdJuego($datos['id_juego']);
            $m->setTitulo($datos['titulo']);
            $models[] = $m;
        }
        return $models;
    }

    public function getById($id_juego)
    {
        session_start();
        $curl = curl_init($this->url_apirest. "juegos.php?id_juego=". $id_juego);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_HTTPHEADER, array('api-key: '.$_SESSION['token']));
        $data = curl_exec($curl);
    
        $array_respuesta = json_decode($data, true);
        $array_datos = isset($array_respuesta['items']) ? $array_respuesta['items'] : array();
        $m = null;
        if (count($array_datos) > 0) {
            $datos = $array_datos[0];
            $m = new JuegoModel();
            $m->setIdJuego($datos['id_juego']);
            $m->setTitulo($datos['titulo']);
        }
        return $m;
    }

    public function insert(){
        session_start();
        $parametros = array(
            'id_desarrollador' => $_REQUEST['id_desarrollador'],
            'id_distribuidor' => $_REQUEST['id_distribuidor'],
            'id_pegi' => $_REQUEST['id_pegi'],
            'titulo' => $_REQUEST['titulo'],
            'descripcion_corta' => $_REQUEST['descripcion_corta'],
            'descripcion_larga' => $_REQUEST['descripcion_larga'],
            'portada_v' => $_REQUEST['portada_v'],
            'portada_h' => $_REQUEST['portada_h'],
            'hero' => $_REQUEST['hero'],
            'logo' => $_REQUEST['logo'],
            'metacritic' => $_REQUEST['metacritic'],
            'fecha_lanzamiento' => $_REQUEST['fecha_lanzamiento'],
            'fecha_publicacion' => $_REQUEST['fecha_publicacion'],
            'destacado' => $_REQUEST['destacado']
        );
        $ch = curl_init($this->url_apirest.'juegos.php');
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json', 'api-key: '.$_SESSION['token']));
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($parametros));
        $response = curl_exec($ch);
   
        echo $response;
    }

    public function update($id_juego){
        session_start();
        $ch = curl_init($this->url_apirest. "juegos.php?id_juego=". $id_juego);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "PUT");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($_REQUEST));
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json', 'api-key: '.$_SESSION['token']));
        curl_exec($ch);
    
    }

    public function delete($id_juego){
        session_start();
        $ch = curl_init($this->url_apirest. "juegos.php?id_juego=". $id_juego);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "DELETE");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('api-key: '.$_SESSION['token']));
        curl_exec($ch);
       
    }
}