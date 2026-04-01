<?php
/**
 * Clase con la lógica para conectarse a la base de datos. 
 */
class Database
{
    private $connection;
    private $results_page = 50;

    public function __construct(){
        $this->connection = new mysqli('db', 'root', 'root', 'Proyecto_Final', '3306');

        if($this->connection->connect_errno){
            echo 'Error de conexión a la base de datos';
            exit;
        }
    }

    /**
     * Método para recuperar datos con soporte para rangos (_min, _max)
     */
    public function getDB($table, $extra = null)
    {
        $page = 0;
        $query = "SELECT * FROM $table";

        if(isset($extra['page'])){
            $page = $extra['page'];
            unset($extra['page']);
        }

        // Eliminamos 'url' si viene en los parámetros para que no ensucie la SQL
        if(isset($extra['url'])){
            unset($extra['url']);
        }

        if(!empty($extra)){
            $query .= ' WHERE';
            $conditions = array();

            foreach ($extra as $key => $value) {
                // Lógica de rangos
                if (strpos($key, '_min') !== false) {
                    $real_field = str_replace('_min', '', $key);
                    $conditions[] = "$real_field >= '$value'";
                } elseif (strpos($key, '_max') !== false) {
                    $real_field = str_replace('_max', '', $key);
                    $conditions[] = "$real_field <= '$value'";
                } else {
                    // Búsqueda exacta normal
                    $conditions[] = "$key = '$value'";
                }
            }
            $query .= ' ' . implode(' AND ', $conditions);
        }

        if($page > 0){
            $since = (($page-1) * $this->results_page);
            $query .= " LIMIT $since, $this->results_page";
        } else {
            $query .= " LIMIT 0, $this->results_page";
        }

        $results = $this->connection->query($query);
        $resultArray = array();

        if($results){
            foreach ($results as $value) {
                $resultArray[] = $value;
            }
        }

        return $resultArray;
    }

    /**
     * Método para ejecutar consultas personalizadas (Necesario para FAVORITOS)
     */
    public function executeCustomQuery($sql, $params = array()) {
        // Preparamos la consulta reemplazando los placeholders manuales
        foreach ($params as $key => $val) {
            $val = $this->connection->real_escape_string($val);
            $sql = str_replace($key, "'$val'", $sql);
        }
        
        $this->connection->query($sql);
        return $this->connection->affected_rows;
    }

    public function insertDB($table, $data)
    {
        $fields = implode(',', array_keys($data));
        $values = '"';
        $values .= implode('","', array_values($data));
        $values .= '"';

        $query = "INSERT INTO $table (".$fields.') VALUES ('.$values.')';
        $this->connection->query($query);

        return $this->connection->insert_id;
    }

    public function updateDB($table, $id, $pk, $data)
    {   
        $query = "UPDATE $table SET ";
        foreach ($data as $key => $value) {
            $query .= "$key = '$value'";
            if(sizeof($data) > 1 && $key != array_key_last($data)){
                $query .= " , ";
            }
        }

        $query .= ' WHERE '. $pk . ' = '.$id;
        $this->connection->query($query);

        return $this->connection->affected_rows;
    }

    public function deleteDB($table, $id, $pk)
    {
        $query = "DELETE FROM $table WHERE $pk = $id";
        $this->connection->query($query);

        return $this->connection->affected_rows;
    }
}
?>