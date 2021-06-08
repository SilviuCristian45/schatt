<?php
    require '../server/config.php';
    session_start();
    $userto = $_GET["userto"];

    if(isset($_GET["currentTime"])){//daca s-a trimis timestampului ultimului mesaj afisat
        $currentTime = $_GET["currentTime"];
        $currentTime = date_create($currentTime);
    }
    else $currentTime = "0";

    $sql = "SELECT direct_messages.timestampp,direct_messages.content,
    direct_messages.userfrom FROM `direct_messages` 
    WHERE (direct_messages.userfrom = ".$_SESSION["userid"]." and direct_messages.userto = " . $userto . ") or 
    (direct_messages.userto = ".$_SESSION["userid"]." and direct_messages.userfrom = ". $userto .") ORDER BY direct_messages.timestampp DESC";

    $result = mysqli_query($conn, $sql);

    while ($row = mysqli_fetch_assoc($result)) {
        $dateDB = date_create($row["timestampp"]);
        if ($dateDB > $currentTime || $currentTime == "0") {
            echo "<p> (" . $row["timestampp"] . ") ";
            if ($row["userfrom"] == $_SESSION["userid"]) //in loc de 3 va trebui sa fie id-ul userului curent
                echo "<b> tu : ";
            else echo " el/ea : ";

            $contentMsg = strtolower($row["content"]);//stochez cu litere mici valoarea curenta
            //stochez in variabila isImage daca e path de imagine 
            $isImage = strpos($contentMsg, ".jpg") || strpos($contentMsg, ".png") || strpos($contentMsg, ".jpeg");
            $isVideo = strpos($contentMsg, ".mp4") || strpos($contentMsg, ".m4v");
            if ($isImage) {//daca e un path de poza si nu text
                echo "<img src=../uploads/". $row["content"]. " width=100 height=100>  </p>";
            }
            else if($isVideo){
                $videoName = $row["content"];
                $videoContent = "<video controls width=300 height=200> <source src=../uploads/".$videoName."> </video>";
                echo "<p> '$videoContent' </p>";
            }
            else 
                echo $row["content"] . "</b> </p>";
        }   
    }
?>