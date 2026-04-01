<?php
// Controlador general para la aplicación
class AppController {
    // Atributo con el motor de plantillas del microframework
    protected $view;

    // Constructor. Únicamente instancia un objeto View y lo asigna al atributo
    function __construct() {
        //Creamos una instancia de nuestro mini motor de plantillas
        $this->view = new View();
    }

    // Método del controlador para hacer login
    public function login() {
        require 'models/UsuarioModel.php';

        $usuario = new UsuarioModel();

        // Inicializamos la variable $errores
        $errores = array();

        // Si se ha pulsado el botón de entrar
        if (isset($_REQUEST['submit'])) {

            if(isset($_REQUEST['login']) && isset($_REQUEST['password']))
            {
                $resultado_autenticar = $usuario->autenticar($_REQUEST['login'], $_REQUEST['password']);
                
                if ($resultado_autenticar != "Error"){
                    session_start();
                    $_SESSION['usuario_app'] = $_REQUEST['login'];
                    $_SESSION['token'] = $resultado_autenticar;
                    header("Location: index.php");
                }else{
                    $errores['login'] = "Error en el login y/o password";
                }
            }else{
                $errores['login'] = "Hay que enviar login y password";
            }
        }else{
            $this->view->show("loginView.php", array('errores' => $errores));
        }
    }

      

    // Método para cerrar sesión
    public function logout() {
        // Recuperamos la información de la sesión
        session_start();

        // Y la eliminamos
        session_destroy();
        header("Location: index.php");
    }
}
