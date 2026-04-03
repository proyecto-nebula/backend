<?php
class UsuarioController {
    protected $view;

    function __construct() {
        // Asumimos que tienes una clase View para cargar las plantillas
        $this->view = new View();
    }

    /**
     * Lista todos los usuarios consumiendo la API
     */
    public function listar() {
        require_once 'models/UsuarioModel.php';
        $usuarioModel = new UsuarioModel();

        // En un caso real, el token vendría de la sesión tras el login
        $token = $_SESSION['token'] ?? ''; 

        // Necesitarás implementar un método getAll en tu UsuarioModel 
        // similar al de autenticar pero con GET
        $usuarios = $this->obtenerTodosDeApi($token); 

        $data['usuarios'] = $usuarios;
        $this->view->show("usuarioListarView.php", $data);
    }

    /**
     * Muestra el formulario para crear un usuario
     */
    public function nuevo() {
        $this->view->show("usuarioNuevoView.php");
    }

    /**
     * Ejemplo de cómo procesar el borrado
     */
    public function borrar() {
        $id = $_REQUEST['id'];
        // Aquí llamarías a un método del modelo que haga un DELETE a la API
        // Tras borrar, rediriges:
        header("Location: index.php?controlador=Usuario&accion=listar");
    }

    // Método de apoyo temporal para entender la lógica de petición
    private function obtenerTodosDeApi($token) {
        $conf = Config::singleton();
        $url = $conf->get('url_apirest') . "usuarios.php";

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            'Authorization: Bearer ' . $token // O 'api-key' según tu Auth.class.php
        ));

        $response = curl_exec($ch);
        curl_close($ch);

        $res = json_decode($response, true);
        return $res['items'] ?? [];
    }
}