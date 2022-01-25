<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="../css/admin_notice.css">
    <script src="../js/jquery.js"></script>
    <script src="../js/profile.js"></script>
    <title>울산고등학교 면학실</title>
</head>
<body>
<div id="wrap">
        <div id="header">
            <h1>관리 페이지</h1>
        </div>
        <div id="see_more">
            <img src="../img/ellipsis_circle.png" alt="ellipsis_circle" id="profile">
            <div id="profile_list">
                <li>
                    <a href="write_notice.php">
                        <p>
                            새 공지사항 만들기
                            <img src="../img/doc.png" alt="doc">
                        </p>
                    </a>
                </li>
            </div>
        </div>
        <div id="main">
            <ul>
                <?php include '../database/select_notice.php'; ?>
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
                <a href="notice.php">
                    <img src="../img/bell_fill.png" alt="bell">
                    <p>공지사항</p>
                </a>
            </div>
        </div>
    </footer>
</body>
</html>