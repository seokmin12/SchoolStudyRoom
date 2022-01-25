<?php
    include '../database/conn.php';

    $title = $_POST['title'];
    $content = $_POST['content'];
    $content = str_replace(')', '', $content);
    $writer = $_POST['writer'];
    

    $insert_sql = "INSERT INTO notice (title, content, writer, created) VALUES ('$title', '$content', '$writer', NOW())";
    $result = mysqli_query($conn, $insert_sql);

    if ($result == TRUE) {
        $val = array("result"=>"success");
    } else {
        $val = array("result"=>"fail");
    }
    echo json_encode($val);

?>