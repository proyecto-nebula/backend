
<?php
namespace App\Classes;
use App\Models\Database;
use App\Utils\Response;
/**
 * Clase para el modelo que representa a la tabla "screenshots".
 */
    /**
     * Realiza type casting de campos numéricos/bool en una captura o lista de capturas
     */
    public static function castScreenshotNumericFields($screenshot) {
        if (is_array($screenshot) && isset($screenshot[0]) && is_array($screenshot[0])) {
            // Lista de capturas
            foreach ($screenshot as &$item) {
                $item = self::castScreenshotNumericFields($item);
            }
            return $screenshot;
        }
        if (is_array($screenshot)) {
            if (isset($screenshot['id'])) $screenshot['id'] = (int)$screenshot['id'];
            if (isset($screenshot['game_id'])) $screenshot['game_id'] = (int)$screenshot['game_id'];
        }
        return $screenshot;
    }

class Screenshots extends Database {
    /**
     * Atributo que indica la tabla asociada a la clase del modelo
     */
    private $table = 'screenshots';

    /**
     * Atributo que indica la columna que es primary key en la tabla
     */
    private $primary_key = 'id';


    /**
     * Array con los campos de la tabla que se pueden usar como filtro para recuperar registros
     */
    private $allowedConditions_get = array(
        'id',
        'game_id'
    );

    /**
     * Array con los campos de la tabla que se pueden proporcionar para insertar registros
     */
    private $allowedConditions_insert = array(
        'game_id',
        'image_url'
    );

    /**
     * Método privado para filtrar los parámetros recibidos y evitar errores con las rutas del .htaccess
     */
   private function filtrarParametros($params, $allowed) {
        foreach ($params as $key => $value) {
    //         // Ignoramos 'url' y cualquier parámetro que empiece por 'id' (id_captura, id_juego, id...)
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

        if (!isset($data['game_id']) || empty($data['game_id']) || !isset($data['image_url']) || empty($data['image_url'])) {
            $response = array(
                'result' => 'error',
                'details' => 'Los campos id_juego e imagen son obligatorios'
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
        // Validación de parámetros permitidos y limpieza de basura del .htaccess
        $this->filtrarParametros($params, $this->allowedConditions_get);

        // Si se pasa 'id', buscar por id y devolver solo el primer resultado
        if (isset($params['id'])) {
            $items = parent::getDB($this->table, ['id' => $params['id']]);
            if (count($items) > 0) {
                return self::castScreenshotNumericFields($items[0]);
            } else {
                return null;
            }
        }

        $items = parent::getDB($this->table, $params);
        return self::castScreenshotNumericFields($items);
    }

    /**
     * Método para guardar un registro en la base de datos, recibe como parámetro el JSON con los datos a insertar
     */
    public function insert($params) {
        // Validación de parámetros permitidos
        $this->filtrarParametros($params, $this->allowedConditions_insert);

        if ($this->validate($params)) {
            $result = parent::insertDB($this->table, $params);
            return self::castScreenshotNumericFields($result);
        }
    }

    /**
     * Método para actualizar un registro en la base de datos mediante PUT, se indica el id del registro que se quiere actualizar
     */
    public function updatePut($id, $params) {
        // Validación de parámetros permitidos
        $this->filtrarParametros($params, $this->allowedConditions_insert);

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
        // Validación de parámetros permitidos
        $this->filtrarParametros($params, $this->allowedConditions_insert);

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
}
?>