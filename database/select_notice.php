<?php
    include 'conn.php';

    $select_sql = "SELECT * FROM notice ORDER BY number DESC;";
    $select_result = mysqli_query($conn, $select_sql);

    $chk_row = mysqli_num_rows($select_result);
    if ($chk_row != 0) {
        while ($select_row = mysqli_fetch_array($select_result)) {
            $title = $select_row['title'];
            $content = $select_row['content'];
            $writer = $select_row['writer'];
            $created = $select_row['created'];
        ?>
        <li>
            <p>
                <?= $title ?>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <?= $created ?>
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