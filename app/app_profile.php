<?php
    include 'app_inc_head.php';

    $name = $_SESSION['name'];
    $warning = $_SESSION['warning'];

    echo json_encode(array("name"=>$name, "warning"=>$warning));

?>