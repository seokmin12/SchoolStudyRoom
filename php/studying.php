<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="../css/studying.css?after">
    <title>울산고등학교 면학실</title>
</head>
<body>
    <div id="wrap">
        <div id="header">
            <h1>관리 페이지</h1>
        </div>
        <div id="main">
            <ul>
                <?php include '../database/select_studying_member.php'; ?>
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