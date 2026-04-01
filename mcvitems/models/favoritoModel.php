<?php

// Clase del modelo para trabajar con la tabla FAVORITOS
class FavoritoModel
{
    protected $url_apirest;

    public function __construct() {
        $conf = Config::singleton();
        $this->url_apirest = $conf->get('url_apirest');
    }

    public function insert(){
        session_start();
        $parametros = array('id_usuario' => $_REQUEST['id_usuario'], 'id_juego' => $_REQUEST['id_juego']);
        $ch = curl_init($this->url_apirest.'favoritos.php');
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json', 'api-key: '.$_SESSION['token']));
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($parametros));
        $response = curl_exec($ch);
        curl_close($ch);
        echo $response;
    }

    public function delete($id_usuario){
        session_start();
        // Borra favoritos del usuario
        $ch = curl_init($this->url_apirest. "favoritos.php?id_usuario=". $id_usuario);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "DELETE");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('api-key: '.$_SESSION['token']));
        curl_exec($ch);
        curl_close($ch);
    }
}