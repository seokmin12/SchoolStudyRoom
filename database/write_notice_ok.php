<?php
    include 'conn.php';

    $title = $_POST['title'];
    $content = $_POST['content'];
    $writer = $_SESSION['name'];

    if ($title == '' || $content == '') {
        echo "<script>window.alert('빈칸을 모두 채워주세요.')</script>";
        echo "<script>history.back();</script>";
    } else {
        $insert_sql = "INSERT INTO notice (title, content, writer, created) VALUES ('$title', '$content', '$writer', NOW())";
        $result = mysqli_query($conn, $insert_sql);
        if ($result == TRUE) {
            echo "<script>window.alert('성공적으로 저장되었습니다.')</script>";
            echo "<script>location.href='../php/admin_notice.php';</script>";
        } else {
            echo "<script>window.alert('저장하는 과정에서 문제가 생겼습니다. 관리자에게 문의하세요.')</script>";
            echo "<script>history.back();</script>";
        }
    }
?>