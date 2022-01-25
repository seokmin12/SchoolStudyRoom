<?php
    include '../database/conn.php';

    $select_sql = "SELECT * FROM member WHERE job = 'student' AND study_start not in('NULL') ORDER BY grade ASC;";
    $select_result = mysqli_query($conn, $select_sql);

    $data = array();
    while ($select_row = mysqli_fetch_object($select_result)) {
        array_push($data, $select_row);
    }
    echo json_encode($data);
?>