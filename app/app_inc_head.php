<?php
  session_start();
  if( isset( $_SESSION['grade'] ) ) {
    $user_login = TRUE;
  }
?>