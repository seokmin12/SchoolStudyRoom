<?php
    include '../database/inc_head.php';
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="../css/admin.css?afteaaasr">

    <script src="https://code.jquery.com/jquery-3.6.0.js"
        integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <script src="../js/profile.js"></script>

    <title>울산고등학교 면학실</title>
</head>
<body>
    <div id="wrap">
        <div id="header">
            <h1>관리 페이지</h1>
        </div>
        <div id="profile_side">
            <img src="../img/person_crop_circle_fill.png" alt="person" id="profile">
            <div id="profile_list">
                <li>
                    <p><?php echo $_SESSION['profile'] ?>님</p>
                </li>
                <li id="logout">
                    <p><a href="../database/logout.php">로그아웃</a></p>
                </li>
            </div>
        </div>
        <div id="main">
            <ul>
                <?php include '../database/select_member.php'; ?>
            </ul>
        </div>
        
    </div>


    <footer>
        <div id="tab">
            <div id="item1">
                <a href="admin.php">
                    <img src="../img/person_fill.png" alt="person_fill">
                    <p>학생 정보</p>
                </a>
            </div>
            <div id="item2">
                <a href="studying.php">
                    <img src="../img/pencil.png" alt="pencil">
                    <p>공부중</p>
                </a>
            </div>
            <div id="item3">
                <a href="admin_notice.php">
                    <img src="../img/bell_fill.png" alt="bell">
                    <p>공지사항</p>
                </a>
            </div>
        </div>
    </footer>
</body>
</html>