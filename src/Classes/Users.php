<?php
namespace App\Classes;
/**
 * Clase para el modelo que representa a la tabla "item".
 */
use App\Models\Database;
use App\Utils\Response;

class Users extends Database {
    /**
     * Convierte los campos numéricos/bool a su tipo correcto
     */
    private function castUserNumericFields($user) {
        if (!$user) return $user;
        if (isset($user['id'])) $user['id'] = (int)$user['id'];
        if (isset($user['role_id'])) $user['role_id'] = (int)$user['role_id'];
        if (isset($user['plan_id'])) $user['plan_id'] = (int)$user['plan_id'];
        if (isset($user['avatar_id'])) $user['avatar_id'] = (int)$user['avatar_id'];
        if (isset($user['is_active'])) $user['is_active'] = (bool)$user['is_active'];
        return $user;
    }
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
        'created_at'
    );

    /**
     * Array con los campos de la tabla que se pueden proporcionar para insertar registros
     */
    private $allowedConditions_insert = array(
        'username',
        'role_id',
        'password',
        'email',
        'birth_date',
        'is_active',
        'avatar_id',
        'plan_id',
        'created_at'
    );

    /**
     * Método para validar los datos que se mandan para insertar un registro, comprobar campos obligatorios, valores válidos, etc.
     */
    private function validate($data) {
        // Comprobamos que todos los campos requeridos existan y no estén vacíos
        if (
            !isset($data['username']) || empty($data['username']) ||
            !isset($data['password']) || empty($data['password']) ||
            !isset($data['email']) || empty($data['email'])
        ) {
            $response = array(
                'result' => 'error',
                'details' => 'Los campos username, password y email son obligatorios'
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

        // Si se pasa 'id', buscar por id y devolver solo el primer resultado
        if (isset($params['id'])) {
            $items = parent::getDB($this->table, ['id' => $params['id']]);
            if (count($items) > 0) {
                return $this->castUserNumericFields($items[0]);
            } else {
                return null;
            }
        }

        // Si se pasa 'username', buscar por username y devolver solo el primer resultado
        if (isset($params['username'])) {
            $items = parent::getDB($this->table, ['username' => $params['username']]);
            if (count($items) > 0) {
                return $this->castUserNumericFields($items[0]);
            } else {
                return null;
            }
        }

        $items = parent::getDB($this->table, $params);
        foreach ($items as &$item) {
            $item = $this->castUserNumericFields($item);
        }
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
            $user = $result->fetch_assoc();
            return $this->castUserNumericFields($user);
        }

        return null;
    }
    
}
?>