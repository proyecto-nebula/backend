<?php
namespace App\Classes;
/**
 * Clase para el modelo que representa a la tabla "PEGI".
 */
use App\Models\Database;
use App\Utils\Response;

class Pegi extends Database {
    /**
     * Atributo que indica la tabla asociada a la clase del modelo
     */
    private $table = 'pegi';

    /**
     * Atributo que indica la columna que es primary key en la tabla
     */
    private $primary_key = 'id';


    /**
     * Array con los campos de la tabla que se pueden usar como filtro para recuperar registros
     */
    private $allowedConditions_get = array(
        'id'
    );

    /**
     * Array con los campos de la tabla que se pueden proporcionar para insertar registros
     */
    private $allowedConditions_insert = array(
        'id',
        'name',
        'image_url'
    );

    /**
     * Método privado para filtrar los parámetros recibidos y evitar errores con las rutas del .htaccess
     */
    private function filtrarParametros($params, $allowed) {
        foreach ($params as $key => $value) {
            // Ignoramos 'url' y cualquier parámetro que empiece por 'id'
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

        if (!isset($data['image_url']) || empty($data['image_url']) || !isset($data['name']) || empty($data['name'])) {
            $response = array(
                'result' => 'error',
                'details' => 'El campo imagen y/o nombre es obligatorio'
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

        $items = parent::getDB($this->table, $params);

        return $items;
    }

  public function insert($params) {
        // Si usas filtrarParametros, ponlo aquí
        if (method_exists($this, 'filtrarParametros')) {
            $this->filtrarParametros($params, $this->allowedConditions_insert);
        }

        if ($this->validate($params)) {
            try {
                return parent::insertDB($this->table, $params);
            } catch (\mysqli_sql_exception $e) {
                // Error 1062: ID duplicado
                if ($e->getCode() == 1062) {
                    Response::result(400, array(
                        'result' => 'error',
                        'details' => 'Ya existe un registro PEGI con este identificador'
                    ));
                    exit;
                }
                
                // Por si acaso hubiera alguna clave foránea en PEGI (Error 1452)
                if ($e->getCode() == 1452) {
                    Response::result(404, array(
                        'result' => 'error',
                        'details' => 'Alguna de las referencias indicadas no existe'
                    ));
                    exit;
                }

                throw $e;
            }
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
        $this->filtrarParametros($params, $this->allowedConditions_insert);

        try {
            $affected_rows = parent::updateDB($this->table, $id, $this->primary_key, $params);

            if ($affected_rows == 0) {
                // Esto ocurre si el ID no existe O si los datos son iguales
                Response::result(200, array(
                    'result' => 'error', 
                    'details' => 'No se realizaron cambios (verifique que el ID existe o que los datos son diferentes)'
                ));
                exit;
            }
        } catch (\mysqli_sql_exception $e) {
            // Error 1062: Si intentas actualizar y causas un duplicado
            if ($e->getCode() == 1062) {
                Response::result(400, array(
                    'result' => 'error',
                    'details' => 'Los nuevos datos ya están en uso por otro registro PEGI'
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