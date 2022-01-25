<?php
    include 'conn.php';

    $sql = "SELECT * FROM seats WHERE user = 'none'";
    $result = mysqli_query($conn, $sql);
    $row = mysqli_num_rows($result);
    echo $row;

?>