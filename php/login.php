<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="../css/login.css?aftasser">

    <title>면학실 예약</title>
</head>

<body>
    <div id="wrap">
        <div id="header">
            <img src="../img/lock_fill.png" alt="lock">
        </div>
        <section>
            <h4>로그인 정보</h4>
            <form action="../database/login_ok.php" method="post">
                <li>
                    <input type="number" name="grade" id="grade" placeholder="학년 반 번호">
                </li>
                <li>
                    <input type="password" name="password" id="password" placeholder="비밀번호">
                </li>
                <input type="submit" value="로그인 하기">
            </form>
        </section>
    </div>
</body>

</html>