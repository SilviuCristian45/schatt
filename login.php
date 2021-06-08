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
                    <li> <a href="profile.php" > Profile </a></li>
                    <li> <a href="dm.php"> Direct messages </a></li>
                    <li> <a href="about.html"> About </a></li>
                    <li> <a href="contact.php"> Contact </a></li>
                </ul>
            </nav>
        </div>
        
        <div class="column row" id=chatsections> 
            <p> Login </p>
            <p> <?php 
                    if (isset($_COOKIE["mesajparola"])) {
                        echo $_COOKIE["mesajparola"];
                        setcookie("mesajparola","",time() - 3600,"/");//stergem cookie-ul
                    }
                ?>
            </p>
            <section>
                <form action="server/login.php" method="post">
                   
                    <div class="row" style="padding: 10px;">
                        <label for="username"> Username </label> <input type="text" name="username">
                   </div>

                   <div class="row" style="padding: 10px;">
                        <label for="password"> Password </label> <input type="password" name="password">
                    </div>

                    <p> <input type="submit" value="Logheaza-te"> </p>        
               </form>
            <a href="register.html" id="registerRedirect"> Daca nu aveti cont, inregistrati-va aici. </a>
              
            </section>
        </div>
      
        <footer> Copyright Silviu 2021 </footer>
    </div>  
</body>
</html>