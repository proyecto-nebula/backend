<?php
/**
 * Clase para el modelo que representa a la tabla "item".
 */
require_once __DIR__ . '/../utils/response.php';
require_once __DIR__ . '/../models/database.php';

class users extends Database {
    /**
     * Atributo que indica la tabla asociada a la clase del modelo
     */
    private $table = 'users';

    /**
     * Atributo que indica la columna que es primary key en la tabla
     */
    private $primary_key = 'id';


    /**
     * Array con los campos de la tabla que se pueden usar como filtro para recuperar registros
     */
    private $allowedConditions_get = array(
        'id',
        'token',
        'created_date'
    );

    /**
     * Array con los campos de la tabla que se pueden proporcionar para insertar registros
     */
    private $allowedConditions_insert = array(
        'username',
        'role_id',
        'password',
        'first_name',
        'last_name',
        'email',
        'subscription_date',
        'avatar_id',
        'plan_id',
        'created_date'
    );

    /**
     * Método para validar los datos que se mandan para insertar un registro, comprobar campos obligatorios, valores válidos, etc.
     */
    private function validate($data) {
        // Comprobamos que todos los campos requeridos existan y no estén vacíos
        if (
            !isset($data['username']) || empty($data['username']) ||
            !isset($data['password']) || empty($data['password']) ||
            !isset($data['first_name']) || empty($data['first_name']) ||
            !isset($data['last_name']) || empty($data['last_name']) ||
            !isset($data['email']) || empty($data['email']) 
        ) {
            $response = array(
                'result' => 'error',
                'details' => 'Los campos alias, password, nombre, apellidos y email son obligatorios'
            );

            Response::result(400, $response);
            exit;
        }

        // Encriptamos la contraseña en formato sha256 antes de guardarla en la base de datos
        $data['password'] = hash('sha256', $data['password']);

        return $data;
    }

    /**
     * Método para recuperar registros, pudiendo indicar algunos filtros 
     */
    public function get($params) {
        foreach ($params as $key => $param) {
            if (!in_array($key, $this->allowedConditions_get)) {
                unset($params[$key]);
                $response = array(
                    'result' => 'error',
                    'details' => 'Error en la solicitud'
                );

                Response::result(400, $response);
                exit;
            }
        }

        $items = parent::getDB($this->table, $params);

        return $items;
    }

    /**
     * Método para guardar un registro en la base de datos, recibe como parámetro el JSON con los datos a insertar
     */
    public function insert($params) {
        foreach ($params as $key => $param) {
            if (!in_array($key, $this->allowedConditions_insert)) {
                unset($params[$key]);
                $response = array(
                    'result' => 'error',
                    'details' => 'Error en la solicitud'
                );

                Response::result(400, $response);
                exit;
            }
        }

        // Validamos los datos y obtenemos el array con la password ya encriptada
        $params = $this->validate($params);

        // Generamos un token aleatorio de forma automática para el nuevo usuario
        $params['token'] = bin2hex(random_bytes(16));

        if ($params) {
            return parent::insertDB($this->table, $params);
        }
    }

    /**
     * Método para actualizar un registro en la base de datos mediante PUT, se indica el id del registro que se quiere actualizar
     */
    public function updatePut($id, $params) {
        foreach ($params as $key => $parm) {
            if (!in_array($key, $this->allowedConditions_insert)) {
                unset($params[$key]);
                $response = array(
                    'result' => 'error',
                    'details' => 'Error en la solicitud'
                );

                Response::result(400, $response);
                exit;
            }
        }

        if ($this->validate($params)) {
            $affected_rows = parent::updateDB($this->table, $id, $this->primary_key, $params);

            if ($affected_rows == 0) {
                $response = array(
                    'result' => 'error',
                    'details' => 'No hubo cambios'
                );

                Response::result(200, $response);
                exit;
            }
        }
    }


    /**
     * Método para actualizar un registro en la base de datos mediante PATCH, se indica el id del registro que se quiere actualizar
     */
    public function updatePatch($id, $params) {
        foreach ($params as $key => $parm) {
            if (!in_array($key, $this->allowedConditions_insert)) {
                unset($params[$key]);
                $response = array(
                    'result' => 'error',
                    'details' => 'Error en la solicitud'
                );

                Response::result(400, $response);
                exit;
            }
        }

        $affected_rows = parent::updateDB($this->table, $id, $this->primary_key, $params);

        if ($affected_rows == 0) {
            $response = array(
                'result' => 'error',
                'details' => 'No hubo cambios'
            );

            Response::result(200, $response);
            exit;
        }
    }


    /**
     * Método para borrar un registro de la base de datos, se indica el id del registro que queremos eliminar
     */
    public function delete($id) {
        $affected_rows = parent::deleteDB($this->table, $id, $this->primary_key);

        if ($affected_rows == 0) {
            $response = array(
                'result' => 'error',
                'details' => 'No hubo cambios'
            );

            Response::result(200, $response);
            exit;
        }
    }
    /**
     * Método para recuperar toda la información vinculada del usuario
     */
    public function getPerfilCompleto($id) {
        $sql = "SELECT 
                    u.id, 
                    u.username, 
                    u.first_name, 
                    u.last_name, 
                    u.email,
                    r.id AS role_id,
                    r.name AS role_name,
                    a.image_url AS avatar_image,
                    p.name AS plan_name
                FROM users u
                INNER JOIN roles r ON u.role_id = r.id
                LEFT JOIN avatars a ON u.avatar_id = a.id
                INNER JOIN plans p ON u.plan_id = p.id
                WHERE u.id = $id";
                
        // Obtenemos la conexión mysqli de la clase padre
        $db = $this->getConnection();
        $result = $db->query($sql);

        // Si hay resultados, devolvemos la primera fila como array asociativo
        if ($result && $result->num_rows > 0) {
            return $result->fetch_assoc();
        }

        return null;
    }
    
}
?>