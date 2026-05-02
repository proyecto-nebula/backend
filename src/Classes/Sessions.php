
<?php
namespace App\Classes;
use App\Models\Database;
use App\Utils\Response;
/**
 * Clase para el modelo que representa a la tabla "sessions".
 */
    /**
     * Realiza type casting de campos numéricos/bool en una sesión o lista de sesiones
     */
    public static function castSessionNumericFields($session) {
        if (is_array($session) && isset($session[0]) && is_array($session[0])) {
            // Lista de sesiones
            foreach ($session as &$item) {
                $item = self::castSessionNumericFields($item);
            }
            return $session;
        }
        if (is_array($session)) {
            if (isset($session['id'])) $session['id'] = (int)$session['id'];
            if (isset($session['user_id'])) $session['user_id'] = (int)$session['user_id'];
            if (isset($session['game_id'])) $session['game_id'] = (int)$session['game_id'];
            if (isset($session['duration'])) $session['duration'] = (int)$session['duration'];
        }
        return $session;
    }

class Sessions extends Database {
    /**
     * Atributo que indica la tabla asociada a la clase del modelo
     */
    private $table = 'sessions';

    /**
     * Atributo que indica la columna que es primary key en la tabla
     */
    private $primary_key = 'id';


    /**
     * Array con los campos de la tabla que se pueden usar como filtro para recuperar registros
     */
    private $allowedConditions_get = array(
        'id',
        'user_id',
        'game_id',
        'started_at'
    );

    /**
     * Array con los campos de la tabla que se pueden proporcionar para insertar registros
     */
    private $allowedConditions_insert = array(
        'user_id',
        'game_id',
        'started_at',
        'duration'
    );

    /**
     * Método privado para filtrar los parámetros recibidos y evitar errores con las rutas del .htaccess
     */
    private function filtrarParametros($params, $allowed) {
        foreach ($params as $key => $value) {
            // Ignoramos 'url' y cualquier parámetro que empiece por 'id' (id_partida, id_usuario, etc)
            if ($key === 'url' || strpos($key, 'id') === 0) continue;

            if (!in_array($key, $allowed)) {
                Response::result(400, array(
                    'result' => 'error',
                    'details' => "El campo '$key' no es válido para esta consulta"
                ));
                exit;
            }
        }
    }

    /**
     * Método para validar los datos que se mandan para insertar un registro, comprobar campos obligatorios, valores válidos, etc.
     */
    private function validate($data) {

        if (!isset($data['user_id']) || empty($data['user_id']) || !isset($data['game_id']) || empty($data['game_id'])) {
            $response = array(
                'result' => 'error',
                'details' => 'Los campos id_usuario e id_juego son obligatorios'
            );

            Response::result(400, $response);
            exit;
        }

        return true;
    }

    /**
     * Método para recuperar registros, pudiendo indicar algunos filtros 
     */
    public function get($params) {
        // Validación de parámetros permitidos y limpieza de variables de ruta
        $this->filtrarParametros($params, $this->allowedConditions_get);

        // Si se pasa 'id', buscar por id y devolver solo el primer resultado
        if (isset($params['id'])) {
            $items = parent::getDB($this->table, ['id' => $params['id']]);
            if (count($items) > 0) {
                return self::castSessionNumericFields($items[0]);
            } else {
                return null;
            }
        }

        $items = parent::getDB($this->table, $params);
        return self::castSessionNumericFields($items);
    }

    /**
     * Método para guardar un registro en la base de datos, recibe como parámetro el JSON con los datos a insertar
     */
    public function insert($params) {
        // Validación de parámetros permitidos
        $this->filtrarParametros($params, $this->allowedConditions_insert);

        if ($this->validate($params)) {
            $result = parent::insertDB($this->table, $params);
            return self::castSessionNumericFields($result);
        }
    }

    /**
     * Método para actualizar un registro en la base de datos mediante PUT, se indica el id del registro que se quiere actualizar
     */
    /**
     * Método para actualizar un registro mediante PUT
     */
    public function updatePut($id, $params) {
        $this->filtrarParametros($params, $this->allowedConditions_insert);

        if ($this->validate($params)) {
            try {
                $affected_rows = parent::updateDB($this->table, $id, $this->primary_key, $params);

                if ($affected_rows == 0) {
                    Response::result(200, array('result' => 'error', 'details' => 'No hubo cambios o la partida no existe'));
                    exit;
                }
            } catch (\mysqli_sql_exception $e) {
                // Error 1452: El ID del juego o usuario que intentas poner no existe
                if ($e->getCode() == 1452) {
                    Response::result(404, array(
                        'result' => 'error', 
                        'details' => 'No se puede actualizar: el usuario o el juego indicados no existen'
                    ));
                    exit;
                }
                throw $e;
            }
        }
    }


    /**
     * Método para actualizar parcialmente un registro (PATCH)
     */
    public function updatePatch($id, $params) {
        $this->filtrarParametros($params, $this->allowedConditions_insert);

        try {
            $affected_rows = parent::updateDB($this->table, $id, $this->primary_key, $params);

            if ($affected_rows == 0) {
                Response::result(200, array(
                    'result' => 'error', 
                    'details' => 'No hubo cambios (los datos ya eran iguales o el ID no existe)'
                ));
                exit;
            }
        } catch (\mysqli_sql_exception $e) {
            // Error 1452: Fallo de clave foránea (el ID del juego o usuario no existe)
            if ($e->getCode() == 1452) {
                Response::result(404, array(
                    'result' => 'error', 
                    'details' => 'No se puede actualizar: el usuario o el juego indicados no existen'
                ));
                exit;
            }
            throw $e;
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
}
?>