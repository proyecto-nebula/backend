
<?php
namespace App\Classes;
use App\Models\Database;
use App\Utils\Response;
/**
 * Clase para el modelo que representa a la tabla "categories".
 */
    /**
     * Realiza type casting de campos numéricos/bool en una categoría o lista de categorías
     */
    public static function castCategoryNumericFields($category) {
        if (is_array($category) && isset($category[0]) && is_array($category[0])) {
            // Lista de categorías
            foreach ($category as &$item) {
                $item = self::castCategoryNumericFields($item);
            }
            return $category;
        }
        if (is_array($category)) {
            if (isset($category['id'])) $category['id'] = (int)$category['id'];
        }
        return $category;
    }

class Categories extends Database {
    /**
     * Atributo que indica la tabla asociada a la clase del modelo
     */
    private $table = 'categories';

    /**
     * Atributo que indica la columna que es primary key en la tabla
     */
    private $primary_key = 'id';


    /**
     * Array con los campos de la tabla que se pueden usar como filtro para recuperar registros
     */
    private $allowedConditions_get = array(
        'id',
        'name',
        'image_url'
    );

    /**
     * Array con los campos de la tabla que se pueden proporcionar para insertar registros
     */
    private $allowedConditions_insert = array(
        'name',
        'image_url'
    );

    /**
     * Método privado para filtrar los parámetros recibidos y evitar errores con las rutas del .htaccess
     */
    private function filtrarParametros($params, $allowed) {
        foreach ($params as $key => $value) {
            // Ignoramos 'url' y cualquier ID o campo de búsqueda dinámico que venga del .htaccess
            if ($key === 'url' || strpos($key, 'id') === 0 || $key === 'name') continue;

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

        if (!isset($data['name']) || empty(trim($data['name']))) {
            $response = array(
                'result' => 'error',
                'details' => 'El campo nombre es obligatorio'
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
        // Validación de parámetros permitidos
        $this->filtrarParametros($params, $this->allowedConditions_get);

        // Si se pasa 'id', buscar por id y devolver solo el primer resultado
        if (isset($params['id'])) {
            $items = parent::getDB($this->table, ['id' => $params['id']]);
            if (count($items) > 0) {
                return self::castCategoryNumericFields($items[0]);
            } else {
                return null;
            }
        }

        // Si se pasa 'name', buscar por name y devolver solo el primer resultado
        if (isset($params['name'])) {
            $items = parent::getDB($this->table, ['name' => $params['name']]);
            if (count($items) > 0) {
                return self::castCategoryNumericFields($items[0]);
            } else {
                return null;
            }
        }

        $items = parent::getDB($this->table, $params);
        return self::castCategoryNumericFields($items);
    }

    /**
     * Método para guardar un registro en la base de datos, recibe como parámetro el JSON con los datos a insertar
     */
    public function insert($params) {
        // Validación de parámetros permitidos
        $this->filtrarParametros($params, $this->allowedConditions_insert);

        if ($this->validate($params)) {
            $result = parent::insertDB($this->table, $params);
            return self::castCategoryNumericFields($result);
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