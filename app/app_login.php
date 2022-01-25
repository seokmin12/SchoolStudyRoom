<?php
    include '../database/conn.php';

    session_start();
    $grade = $_POST['grade'];
    $password = $_POST['password'];
    $sql = "SELECT * FROM member WHERE grade = '$grade';";

    $result = mysqli_query($conn, $sql);
    $row = mysqli_fetch_array($result);
    $DBpassword = $row['password'];
    $job = $row['job'];
    if ($job == 'student' and $password == $DBpassword) {
        $resultValue = array("result"=>'success');
        $_SESSION['grade'] = $row['grade'];
        $_SESSION['name'] = $row['name'];
        $_SESSION['warning'] = $row['warning'];
        $_SESSION['start_time'] = $row['start_time'];
        echo json_encode($resultValue);
    } elseif ($job == 'teacher' and $password == $DBpassword) {
        $resultValue = array("result"=>'teacher_success');
        $_SESSION['name'] = $row['name'];
        echo json_encode($resultValue);
    }
    else {
        $resultValue = array("result"=>'fail');
        echo json_encode($resultValue);
    }
?>