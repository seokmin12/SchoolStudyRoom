<?php

session_start(); // 세션

if($_SESSION['grade']!=null){
   session_destroy();
   echo json_encode(array("result"=>"success"));
} else {
    echo json_encode(array("result"=>"fail"));
}
?>