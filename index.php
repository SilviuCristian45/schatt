<?php
    session_start();
    if ( !isset($_SESSION["userid"]) ){//daca user-ul nu e logat # trebuie redirectat pe login.php
        header("location:login.php");
    }
    else{
        require 'server/config.php';
        $sql = "SELECT username from users where users.id = ".$_SESSION["userid"];
        $result = mysqli_fetch_assoc(mysqli_query($conn, $sql));
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
    
    <script
    src="https://code.jquery.com/jquery-3.6.0.js"
    integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
    crossorigin="anonymous"></script>

    <script src="js/index.js" defer></script>
    <script src="js/chatglobal.js" defer></script>
</head>
<body>
    <div id=container>
        <div class="row" id="row1">
            <img src="img/logo.svg" alt="logo" id="logo">
            <nav>
                <ul class="rowright">
                    <li> <a href="index.php" class="currentpage"> Home </a></li>
                    <?php
                        if ($_SESSION["userRank"] == 3)
                            echo '<li> <a href=complaints.php> Admin panel </a></li>';
                    ?>
                    <li> <a href="profile.php"> Profile </a></li>
                    <li> <a href="dm.php"> Direct messages </a></li>
                    <li> <a href="about.html"> About </a></li>
                    <li> <a href="contact.php"> Contact </a></li>
                    <li> <a href="logout.php"> Logout </a></li>
                </ul>
            </nav>
        </div>
        
        <p> Chat global - SCHAT 😀 </p>
        <p> Bun venit pe chat, draga <?php echo '<b>'.$result["username"].'</b>'; ?> </p>
        <p id="log"> </p>
        <div class="row" id="chatsections"> 
            <section id="chatsection">
                
            </section>
            <section id="chatsendsection">
                <textarea> </textarea>
                <div id="sendsection">
                    <button id="sendGlobalChat"> Send </button>
                    <input type="file" id="imagefile">
                </div>
            </section>
            
        </div>
      
        <footer> Copyright Silviu 2021 </footer>
    </div>  
</body>
</html>