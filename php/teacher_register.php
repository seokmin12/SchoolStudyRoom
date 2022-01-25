<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="../css/register.css?afster">
    <title>면학실 예약</title>
</head>

<body>
    <div id="wrap">
        <h1>회원가입 교사용</h1>
        <form action="../database/teacher_register_ok.php" method="post">
            <Section>
                <h4>학년 반 번호</h4>
                <input type="number" name="grade" id="grade" placeholder="예) 10412">
            </Section>
            <section>
                <h4>이름</h4>
                <input type="text" name="name" id="name" placeholder="예) 홍길동">
            </section>
            <section>
                <h4>비밀번호</h4>
                <input type="password" name="pw" id="pw" placeholder="비밀번호">
            </section>
            <section>
                <h4>비밀번호 확인</h4>
                <input type="password" name="pw_chk" id="pw_chk" placeholder="비밀번호 확인">
            </section>
            <input type="submit" value="회원가입 하기">
        </form>
    </div>
</body>

</html>