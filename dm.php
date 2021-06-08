<?php
    require 'server/config.php';
    session_start();

    if (!isset($_SESSION["userid"])) {//daca nu suntem logati nu putem vedea lista de conversatii 
        header("Location:login.php");
    }
    else {
        
        //selectam pe userii la care a trimis user-ul curent macar un mesaj
        $sql = "SELECT DISTINCT users.id,users.username from users inner 
        JOIN direct_messages on users.id = direct_messages.userto WHERE  direct_messages.userfrom =". $_SESSION["userid"];

        //selectam userii care i-au trimis un mesaj la userul curent si stergem din lista pe cei la care
        //i-a trimis si el mesaj . ca sa nu ne apara acelasi conversation box de 2 ori
        $sql2 = "SELECT DISTINCT users.id,users.username from users inner 
        JOIN direct_messages on users.id = direct_messages.userfrom WHERE  direct_messages.userto =". $_SESSION["userid"] .
        " except (" . $sql . ")";

        $result = mysqli_query($conn, $sql);//avem nevoie de lsita de id-uri la care a dat mesaj user-ul curent
        $result2 = mysqli_query($conn, $sql2);
    }
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SCHAT</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=New+Tegomin&display=swap" rel="stylesheet"> 
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="css/profile.css">
    <link rel="stylesheet" href="css/dm.css">
    <script
    src="https://code.jquery.com/jquery-3.6.0.js"
    integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
    crossorigin="anonymous"></script>
    <script src="js/index.js" defer></script>
</head>
<body>
    <div id=container>
        <div class="row" id="row1">
            <img src="img/logo.svg" alt="logo" id="logo">
            <nav>
                <ul class="rowright">
                    <li> <a href="index.php"> Home </a></li>
                    <?php
                        if ($_SESSION["userRank"] == 3) {
                            echo '<li> <a href=complaints.php> Admin panel </a></li>';
                        }
                    ?>
                    <li> <a href="profile.php"> Profile </a></li>
                    <li> <a href="dm.php" class="currentpage"> Direct messages </a></li>
                    <li> <a href="about.html"> About </a></li>
                    <li> <a href="contact.php"> Contact </a></li>
                    <li> <a href="logout.php"> Logout </a></li>
                </ul>
            </nav>
        </div>
        
        <div class="column row" id=chatsections> 
            <h1> Direct messages </h1>
            <section>
                <?php
                    while ($row = mysqli_fetch_assoc($result)) {
                        echo "<div class='conversation'> <a href=conversation.php/?userto=".$row["id"].">". $row["username"] ." </a> </div>";
                    }
                    while ($row = mysqli_fetch_assoc($result2)) {
                        echo "<div class='conversation'> <a href=conversation.php/?userto=".$row["id"].">". $row["username"] ." </a> </div>";
                    }
                ?>
            </section>

            <button id="createdm"> Add conversation </button>
        </div>
      
        <footer> Copyright Silviu 2021 </footer>
    </div>  
</body>
</html>