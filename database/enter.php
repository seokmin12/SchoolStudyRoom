<?php 
    include 'conn.php';
    include 'inc_head.php';

    $grade = $_SESSION['grade'];

    $chk_sql = "SELECT * FROM seats WHERE user = '".$grade."'";
    $chk_result = mysqli_query($conn, $chk_sql);
    $row = mysqli_num_rows($chk_result);
    if ($row != 0) {
        echo "<script>window.alert('이미 입실되셨습니다.')</script>";
        echo "<script>history.back();</script>";
    } else {
        $randomNum = mt_rand(1, 150);

        date_default_timezone_set('Asia/Seoul'); 

        $update_sql = "UPDATE seats SET user = '".$grade."' WHERE number = '".$randomNum."'";
        $start_sql = "UPDATE member SET study_start = '".date("H:i:s")."' WHERE grade = '".$grade."'";

        $start_result = mysqli_query($conn, $start_sql);
        $result = mysqli_query($conn, $update_sql);
        if ($result == false) {
            echo "<script>window.alert('저장하는 과정에서 문제가 생겼습니다. 관리자에게 문의하세요.')</script>";
            echo "<script>history.back();</script>";
        } else {
            echo "<script>window.alert('입실되었습니다.')</script>";
            echo "<script>location.href='../php/main.php';</script>";
        }
    }
?>