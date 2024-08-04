<?php
require '../include/db.php';
$stmt = $pdo->query('SELECT code, name FROM currencies');
$data = [];
while ($row = $stmt->fetch()) {
    $data[] = ['code' => $row['code'], 'name' => $row['name']];
}
echo json_encode(['status' => 'success', 'currencies' => $data]);
?>