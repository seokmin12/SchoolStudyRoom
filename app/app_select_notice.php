<?php
    include '../database/conn.php';

    $select_sql = "SELECT * FROM notice ORDER BY number DESC;";
    $select_result = mysqli_query($conn, $select_sql);

    $data = array();
    while ($select_row = mysqli_fetch_object($select_result)) {
        array_push($data, $select_row);
    }
    echo json_encode($data);
?>