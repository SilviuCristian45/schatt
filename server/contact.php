<?php
    require 'config.php';

    $email = $_POST["email"];
    $problem = $_POST["problem"];

    echo $email . " " . $problem;

    $sql = "INSERT INTO contact(email, content) VALUES ('$email', '$problem');";
    mysqli_query($conn, $sql) or die("Problema la trimitere. ");

    //setam niste cookieuri pentru a afisa dupa daca s-a executat cu succes query-ul
    setcookie("mesajcontact","Problema dumneavoastra a fost trimisa. Va multumim !",time() + (86400 * 30), "/");
    header('Location: ../contact.php');
?>