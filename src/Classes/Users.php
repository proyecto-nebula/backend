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

        // Si se pasa 'id', devolver perfil completo (joins con role, avatar y plan)
        if (isset($params['id'])) {
            $user = $this->getPerfilCompleto($params['id']);
            return $user ?: null;
        }

        // Si se pasa 'username', buscar por username y devolver perfil completo
        if (isset($params['username'])) {
            $items = parent::getDB($this->table, ['username' => $params['username']]);
            if (count($items) > 0) {
                $id = $items[0]['id'];
                return $this->getPerfilCompleto($id);
            } else {
                return null;
            }
        }

        // Para listados, obtener registros básicos y embeber role, avatar y plan
        $items = parent::getDB($this->table, $params);
        foreach ($items as &$item) {
            $item = $this->castUserNumericFields($item);
            $item['role'] = $this->getRoleById($item['role_id']);
            $item['avatar'] = $this->getAvatarById($item['avatar_id']);
            $item['plan'] = $this->getPlanById($item['plan_id']);
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
        // Recuperar datos básicos del usuario
        $items = parent::getDB($this->table, ['id' => $id]);
        if (count($items) === 0) return null;

        $user = $items[0];
        $user = $this->castUserNumericFields($user);

        // Adjuntar relaciones embebidas: role, avatar, plan
        $user['role'] = $this->getRoleById($user['role_id'] ?? null);
        $user['avatar'] = $this->getAvatarById($user['avatar_id'] ?? null);
        $user['plan'] = $this->getPlanById($user['plan_id'] ?? null);

        return $user;
    }
    
    /**
     * Devuelve la información del role por id
     */
    private function getRoleById($roleId) {
        if (!$roleId) return null;
        $conn = $this->getConnection();
        $sql = "SELECT id, name FROM roles WHERE id = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('i', $roleId);
        $stmt->execute();
        $result = $stmt->get_result();
        $role = $result->fetch_assoc();
        $stmt->close();
        return $role ?: null;
    }

    /**
     * Devuelve la información del avatar por id
     */
    private function getAvatarById($avatarId) {
        if (!$avatarId) return null;
        $conn = $this->getConnection();
        $sql = "SELECT id, name, image_url FROM avatars WHERE id = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('i', $avatarId);
        $stmt->execute();
        $result = $stmt->get_result();
        $avatar = $result->fetch_assoc();
        $stmt->close();
        return $avatar ?: null;
    }

    /**
     * Devuelve la información del plan por id
     */
    private function getPlanById($planId) {
        if (!$planId) return null;
        $conn = $this->getConnection();
        $sql = "SELECT id, name, price FROM plans WHERE id = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('i', $planId);
        $stmt->execute();
        $result = $stmt->get_result();
        $plan = $result->fetch_assoc();
        $stmt->close();
        return $plan ?: null;
    }

    /**
     * Devuelve el perfil completo a partir de un token (lookup) o null
     */
    public function getByToken($token) {
        if (!$token) return null;
        $items = parent::getDB($this->table, ['token' => $token]);
        if (count($items) === 0) return null;
        $id = $items[0]['id'];
        return $this->getPerfilCompleto($id);
    }
    
}
?>