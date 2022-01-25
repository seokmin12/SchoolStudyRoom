<?php 
    include 'conn.php';
    include 'inc_head.php';

    $grade = $_SESSION['grade'];
    $start_time = $_SESSION['start_time'];
    $warning = $_SESSION['warning'];

    date_default_timezone_set('Asia/Seoul');
    $now_time = date("H:i:s");
    if (abs($now_time - $start_time) > 23) {
        $warning_sql = "UPDATE member SET warning = $warning + 1 WHERE grade = '".$grade."'";
        $wanring_result = mysqli_query($conn, $warning_sql);
    }

    $chk_sql = "SELECT * FROM seats WHERE user = '".$grade."'";
    $chk_result = mysqli_query($conn, $chk_sql);
    $row = mysqli_num_rows($chk_result);
    if ($row == 0) {
        echo "<script>window.alert('이미 퇴실되셨습니다.')</script>";
        echo "<script>history.back();</script>";
    } else {
        $update_sql = "UPDATE seats SET user = 'none' WHERE user = '".$grade."'";
        $end_sql = "UPDATE member SET study_start = 'NULL' WHERE grade = '".$grade."'";

        $end_result = mysqli_query($conn, $end_sql);
        $result = mysqli_query($conn, $update_sql);
        if ($result == false) {
            echo "<script>window.alert('저장하는 과정에서 문제가 생겼습니다. 관리자에게 문의하세요.')</script>";
            echo "<script>history.back();</script>";
        } else {
            echo "<script>window.alert('퇴실되었습니다.')</script>";
            echo "<script>location.href='../php/main.php';</script>";
        }
    }
?>