<?php
  //this is returning a list with global messages
    $servername = "localhost";
    $username = "root";
    $password = "";
    $database = "schat";
    
    // Create connection
    $conn = mysqli_connect($servername, $username, $password,$database);
    
    // Check connection
    if (!$conn) {
      die("Connection failed: " . mysqli_connect_error());
    }
?>