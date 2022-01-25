<?php
    include '../database/conn.php';

    $title = $_POST['title'];

    $delete_sql = "DELETE FROM notice WHERE title = '$title'";
    $result = mysqli_query($conn, $delete_sql);

    if($result == TRUE) {
        $val = array("result"=>"success");
    } else {
        $val = array("result"=>"fail");
    }
    echo json_encode($val);
?>