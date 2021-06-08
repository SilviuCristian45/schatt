<?php
    require "config.php";

    $username = $_POST["username"];
    $password = $_POST["password"];

    //se pot face mai multe validari aici 
    //sau direct din front end  

    $sql = "SELECT * FROM users where username = '$username';";
    $result = mysqli_fetch_assoc(mysqli_query($conn, $sql));
    
    //daca ce e in baza de date corespunde cu hash-ul a ceea ce a introdus userul in formular ,logam
    if (password_verify($password, $result["password"]) ) {
        session_start();
        $_SESSION["userRank"] = $result["idgrad"];
        $_SESSION["userid"] = $result["id"];
        header("Location:../index.php");
    }
    else {
        setcookie("mesajparola","Eroare . Parola sau username incorecte",time() + (86400 * 30), "/");
        header('Location:../login.php');
    }    
?>