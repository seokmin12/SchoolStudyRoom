<?php
    include '../database/conn.php';
                // 데이터 나열
    $select_sql = "SELECT * FROM member WHERE job = 'student' AND study_start not in('NULL') ORDER BY grade DESC;";
    $select_result = mysqli_query($conn, $select_sql); 
    $chk_row = mysqli_num_rows($select_result);
    if ($chk_row != 0) {
        while ($select_row = mysqli_fetch_array($select_result)) {
            $grade = $select_row['grade'];
            $name = $select_row['name'];
            $warning = $select_row['warning'];
        ?>
        <li>
            <p>
                <img src="../img/Person.png" alt="person">
                <?= $grade ?>
                <?= $name ?>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                경고: <?= $warning ?>회
            </p>
        </li>
    <?php } 
     } else { ?>
        <li>
            <p style="color: gray;">
                Empty Set
            </p>
        </li>
    <?php } ?>