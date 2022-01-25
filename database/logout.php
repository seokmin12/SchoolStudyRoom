<?php

session_start(); // 세션

if($_SESSION['profile']!=null){
   session_destroy();
}

echo "<script>location.href='../index.html';</script>";

?>