<?php
    include 'conn.php';

    $grade = $_POST['grade'];
    $name = $_POST['name'];
    $pw = $_POST['pw'];
    $pw_chk = $_POST['pw_chk'];
    $year = date('Y');

    if ($grade == '' || $name == '' || $pw == '' || $pw_chk == '') {
        echo "<script>window.alert('빈칸을 모두 입력해주세요.')</script>";
        echo "<script>history.back();</script>";
    } elseif ($pw != $pw_chk) {
        echo "<script>window.alert('비밀번호가 일치하지 않습니다.')</script>";
        echo "<script>history.back();</script>";
    } else {
        $insert_sql = "INSERT INTO member (grade, name, password, warning, study_start, job, year, created) VALUES ('$grade', '$name', '$pw', '0', 'NULL', 'student', '$year',  NOW())";

        $result = mysqli_query($conn, $insert_sql);

        if ($result == false) {
            echo "<script>window.alert('저장하는 과정에서 문제가 생겼습니다. 관리자에게 문의하세요.')</script>";
            echo "<script>history.back();</script>";
        } else {
            echo "<script>window.alert('성공적으로 저장되었습니다.')</script>";
            echo "<script>location.href='../index.html';</script>";
        }
    }
?>