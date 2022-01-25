<?php
  session_start();
  if( isset( $_SESSION['profile'] ) ) {
    $user_login = TRUE;
  }
?>