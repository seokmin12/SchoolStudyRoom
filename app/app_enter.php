<?php
    include '../database/conn.php';
    include 'app_inc_head.php';

    $grade = $_SESSION['grade'];

    $chk_sql = "SELECT * FROM seats WHERE user = '".$grade."'";
    $chk_result = mysqli_query($conn, $chk_sql);
    $row = mysqli_num_rows($chk_result);
    if ($row != 0) {
        echo json_encode(array("result"=>'already'));
    } else {
        $randomNum = mt_rand(1, 150);

        date_default_timezone_set('Asia/Seoul'); 

        $update_sql = "UPDATE seats SET user = '".$grade."' WHERE number = '".$randomNum."'";
        $start_sql = "UPDATE member SET study_start = '".date("H:i:s")."' WHERE grade = '".$grade."'";

        $start_result = mysqli_query($conn, $start_sql);
        $result = mysqli_query($conn, $update_sql);
        if ($result == false) {
            echo json_encode(array("result"=>'error'));
        } else {
            echo json_encode(array("result"=>'success'));
        }
    }

?>