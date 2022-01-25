<?php
    include 'conn.php';

    session_start(); // 세션
    $grade = $_POST['grade'];
    $pw = $_POST['password'];

    $sql = "SELECT * FROM member WHERE grade='$grade'";

    $result = mysqli_query($conn, $sql);
    $row = mysqli_fetch_array($result);
    $DBpassword = $row['password'];
    $job = $row['job'];

    if ($job == 'student' and $pw == $DBpassword) {
        $_SESSION['profile'] = $row['name'];
        $_SESSION['grade'] = $row['grade'];
        $_SESSION['warning'] = $row['warning'];
        $_SESSION['start_time'] = $row['start_time'];
        echo "<script>location.href='../php/main.php';</script>";
    } elseif ($job == 'teacher' and $pw == $DBpassword) {
        $_SESSION['profile'] = $row['name'];
        echo "<script>location.href='../php/admin.php';</script>";
    } else {
        echo "<script>window.alert('잘못된 반 번호 또는 비빌번호 입니다');</script>"; // 잘못된 아이디 또는 비빌번호 입니다
        echo "<script>history.back();</script>";
    }


?>