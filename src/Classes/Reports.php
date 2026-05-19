<?php
namespace App\Classes;
use App\Models\Database;
use App\Utils\Response;

class Reports extends Database {

    private $table = 'reports';
    private $primary_key = 'id';

    private $allowedConditions_insert = ['game_id', 'user_id', 'type', 'description'];
    private $allowedConditions_patch  = ['is_solved'];

    private function validate($data) {
        if (empty($data['game_id']) || !isset($data['type'])) {
            Response::result(400, ['result' => 'error', 'details' => 'game_id y type son obligatorios']);
            exit;
        }
        if (!in_array((int)$data['type'], [1, 2, 3, 4])) {
            Response::result(400, ['result' => 'error', 'details' => 'Tipo no válido (1-4)']);
            exit;
        }
        return true;
    }

    public function get($params) {
        $conn = $this->getConnection();
        $conditions = [];

        if (isset($params['id'])) {
            $conditions[] = 'r.id = ' . (int)$params['id'];
        }

        if (isset($params['is_solved'])) {
            $conditions[] = 'r.is_solved = ' . (int)$params['is_solved'];
        }

        $where = count($conditions) > 0 ? 'WHERE ' . implode(' AND ', $conditions) : '';

        $sql = "SELECT r.id, r.game_id, r.user_id, r.type, r.description,
                       r.is_solved, r.created_at, g.title AS game_title, g.slug AS game_slug
                FROM reports r
                LEFT JOIN games g ON r.game_id = g.id
                {$where}
                ORDER BY r.created_at DESC
                LIMIT 0, 500";

        $result = $conn->query($sql);
        $rows = [];
        foreach ($result as $row) {
            $rows[] = $row;
        }

        if (isset($params['id'])) {
            return count($rows) > 0 ? $rows[0] : null;
        }
        return $rows;
    }

    public function insert($params) {
        foreach (array_keys($params) as $key) {
            if (!in_array($key, $this->allowedConditions_insert)) {
                unset($params[$key]);
            }
        }
        if ($this->validate($params)) {
            return parent::insertDB($this->table, $params);
        }
    }

    public function updatePatch($id, $params) {
        $filtered = array_filter(
            $params,
            fn($k) => in_array($k, $this->allowedConditions_patch),
            ARRAY_FILTER_USE_KEY
        );
        if (!empty($filtered)) {
            parent::updateDB($this->table, $id, $this->primary_key, $filtered);
        }
    }

    public function delete($id) {
        parent::deleteDB($this->table, $id, $this->primary_key);
    }
}
