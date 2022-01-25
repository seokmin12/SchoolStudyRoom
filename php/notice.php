<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link rel="stylesheet" href="../css/notice.css">
    <title>울산고등학교 면학실</title>
</head>
<body>
    <div id="wrap">
        <div id="header">
            <h1>공지사항</h1>
        </div>
        <div id="main">
            <ul>
                <?php include '../database/select_notice.php'; ?>
            </ul>
        </div>
    </div>
</body>
</html>