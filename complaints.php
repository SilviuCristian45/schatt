<?php
    session_start();

    if(!isset($_SESSION["userid"]))//daca nu e logat
        header("Location:login.php");//redirectam la login.php
    else{
        require 'server/config.php';
        $sql = "SELECT idgrad from users where users.id = ".$_SESSION["userid"];
        $result = mysqli_fetch_assoc(mysqli_query($conn, $sql));
        if ($result["idgrad"] != 3) {//daca nu e admin atunci redirectam la index si afisam un mesaj
            header("Location:index.php");
        }
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
    <link rel="stylesheet" href="css/complaints.css">

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
                        if ($_SESSION["userRank"] == 3)
                            echo '<li> <a href=complaints.php> Admin panel </a></li>';
                    ?>
                    <li> <a href="profile.php" > Profile </a></li>
                    <li> <a href="dm.php"> Direct messages </a></li>
                    <li> <a href="about.html"> About </a></li>
                    <li> <a href="contact.php"> Contact </a></li>
                    <li> <a href="logout.php"> Logout </a></li>
                </ul>
            </nav>
        </div>
        
        
        <div class="column row" id=chatsections> 
            <div>
                <h2>Utilizatori inregistrati pe site </h2>
                <?php

                    $sql = "SELECT numberUsers()";
                    $numberUsers = mysqli_fetch_assoc(mysqli_query($conn, $sql));

                    echo "<p>" . $numberUsers["numberUsers()"] . "</p>";
                ?>
            </div>

            <div>
                <h2> Moderatori </h2>
                <?php

                    $sql = "SELECT * FROM `moderatori` ";
                    $moderatori = mysqli_query($conn, $sql);
                    while ($row = mysqli_fetch_assoc($moderatori)) {
                        echo "<p>" . $row["username"] . "</p>";
                    }
                ?>
            </div>

            <div>
                <h2> Admini </h2>
                <?php

                    $sql = "SELECT * FROM `admini` ";
                    $moderatori = mysqli_query($conn, $sql);
                    while ($row = mysqli_fetch_assoc($moderatori)) {
                        echo "<p>" . $row["username"] . "</p>";
                    }
                ?>
            </div>
            <h2> Probleme semnalate de utilizatori </h2>
            <section>
               <table>
                <tr>
                    <th class=smalltabletColumn> Mail utilzator </th>
                    <th> Continut mesaj </th>
                    <th class=tabletColumn> Timestamp </th>
                    <th> Done </th>
                </tr>
                <?php
                    $sql = "SELECT * FROM contact ORDER BY timestampp DESC";
                    $result = mysqli_query($conn, $sql);
                    $numberRows = mysqli_num_rows($result);
                
                    while ($row = mysqli_fetch_assoc($result)) {
                        echo "<tr>";
                        echo "<td class=smalltabletColumn>" . $row["email"] . "</td>" . "<td>" . $row["content"] . "</td>";
                        echo "<td class=tabletColumn>" . $row["timestampp"] . "</td>";

                        echo  "<td>";
                        if ($row["done"]) 
                            echo '<a href=server/checkcomplaint.php/?complaintid='.$row["id"].'>' . '<img src=img/check.svg>' . '</td>';
                        else 
                            echo '<a href=server/checkcomplaint.php/?complaintid='.$row["id"].'>' .'<img src=img/uncheck.svg>' . '</td>';
                        
                        echo "</tr>";
                    }
                    
                ?>
               </table>
            </section>
        </div>
      
        <footer> Copyright Silviu 2021 </footer>
    </div>  
</body>
</html>