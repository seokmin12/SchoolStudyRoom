<?php
    include '../database/conn.php';
    
    $grade = $_REQUEST['grade'];
    $name = $_REQUEST['name'];
    $pw = $_REQUEST['password'];
    $year = date('Y');

    $chk_sql = "SELECT * FROM member WHERE grade = '".$grade."'";
    $chk_result = mysqli_query($conn, $chk_sql);
    $chk_row = mysqli_num_rows($chk_result);
    if ($chk_row != 0) {
        $value = array("result"=>'already');
        echo json_encode($value);
    } else {
        $insert_sql = "INSERT INTO member (grade, name, password, warning, study_start, job, year, created) VALUES ('$grade', '$name', '$pw', '0', 'NULL', 'student', '$year',  NOW())";
    
        $result = mysqli_query($conn, $insert_sql);
    
        if ($result == false) {
            $value = array("result"=>'fail');
            echo json_encode($value);
        } else {
            $value = array("result"=>'success');
            echo json_encode($value);
        }
    }

?>