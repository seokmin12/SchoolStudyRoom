<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="../css/write_notice.css">
    <title>울산고등학교 면학실</title>
</head>
<body>
    <div id="wrap">
        <div id="header">
            <h1>관리 페이지</h1>
        </div>
        <div id="main">
            <form action="../database/write_notice_ok.php" method="post">
                <Section id="first_section">
                    <h3>공지사항 제목</h3>
                    <input type="text" name="title" id="title" placeholder="제목">
                </Section>
                <Section>
                    <h3>공지사항 내용</h3>
                    <input type="text" name="content" id="content" placeholder="내용">
                </Section>
                <input type="submit" value="저장하기">
            </form>
        </div>
    </div>
</body>
</html>