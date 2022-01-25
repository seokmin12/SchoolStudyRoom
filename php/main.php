<?php
    include '../database/inc_head.php';
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="../css/main.css?aftser">

    <script src="../js/jquery.js"></script>
    <script src="../js/profile.js?after"></script>
    <title>면학실 예약</title>
</head>

<body>
    <header>
        <img src="../img/person_crop_circle_fill.png" alt="person" id="profile">
        <div id="profile_list">
            <li>
                <p><?php echo $_SESSION['profile'] ?>님</p>
            </li>
            <li>
                <p>경고: <?php echo $_SESSION['warning'] ?>회<img src="../img/exclamationmark_triangle_fill.png" alt="exclamationmark.triangle.fill"></p>
            </li>
            <li id="logout">
                <p><a href="../database/logout.php">로그아웃</a></p>
            </li>
        </div>
    </header>

    <!-- 150석 -->
    <div id="main">
        <h2>
            <?php include '../database/empty_seats.php' ?>석 남았습니다.
        </h2>
        <form action="../database/enter.php" method="post">
            <input type="submit" value="입실">
        </form>
        <form action="../database/leave.php" method="post">
            <input type="submit" value="퇴실">
        </form>
        <h3>※ 24시간 동안 퇴실하지 않으면 경고 1회입니다.<br>경고가 3회 누적시 불이익이 있을 수 있습니다.</h3>
    </div>
</body>

</html>