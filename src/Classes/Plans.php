
<?php
namespace App\Classes;
use App\Models\Database;
use App\Utils\Response;
/**
 * Clase para el modelo que representa a la tabla "plans".
 */
	/**
	 * Realiza type casting de campos numéricos/bool en un plan o lista de planes
	 */
	public static function castPlanNumericFields($plan) {
		if (is_array($plan) && isset($plan[0]) && is_array($plan[0])) {
			// Lista de planes
			foreach ($plan as &$item) {
				$item = self::castPlanNumericFields($item);
			}
			return $plan;
		}
		if (is_array($plan)) {
			if (isset($plan['id'])) $plan['id'] = (int)$plan['id'];
			if (isset($plan['price'])) $plan['price'] = (float)$plan['price'];
		}
		return $plan;
	}

class Plans extends Database {
	/**
	 * Atributo que indica la tabla asociada a la clase del modelo
	 */
	private $table = 'plans';

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
		'name',
		'description',
		'price'
	);

	/**
	 * Método para validar los datos que se mandan para insertar un registro, comprobar campos obligatorios, valores válidos, etc.
	 */
	private function validate($data) {

		if (!isset($data['name']) || empty($data['name']) || !isset($data['description']) || empty($data['description']) || !isset($data['price']) || empty($data['price'])) {
			$response = array(
				'result' => 'error',
				'details' => 'El campo nombre, descripcion, y precio son obligatorio'
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
				   return self::castPlanNumericFields($items[0]);
			   } else {
				   return null;
			   }
		   }

		   $items = parent::getDB($this->table, $params);
		   return self::castPlanNumericFields($items);
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

		   if ($this->validate($params)) {
			   $result = parent::insertDB($this->table, $params);
			   return self::castPlanNumericFields($result);
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
}
?>
