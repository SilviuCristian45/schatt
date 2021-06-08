<?php
    require 'config.php';
    session_start();

    $currentUser = $_SESSION["userid"]; //stochez id-ul userului din sesiuena curenta
    $msgContent = $_POST["message"];    //stochez mesajul text
    $msgTimestamp = $_POST["timestampp"];   //stochez timestamp-ul la care s-a trimis mesajul
    
 
    if ( isset($_FILES["fileToUpload"]["name"]) ) {//daca s-a incarcat o imagine sau un clip
        $image = $_FILES["fileToUpload"]["name"];   //stochez ce a uploadat user-ul  
        $filefolder = '../uploads/';   //stochez path-ul folder-ului unde incarc fisierul
        $tmpfilename = $_FILES["fileToUpload"]["tmp_name"];     //fisierul inainte de upload va fi mutat intr-un folder temporar
        $filesize = $_FILES["fileToUpload"]["size"];    //marimea in bytes

        //aici trebuie facute niste validari
        $upload = 1;// pp ca putem sa uploadam poza pe server
        $fileLimitUpload = 6000000; //limita de 5 mb per poza

        $mimeType = mime_content_type($tmpfilename);//stochez MIME type-ul fisierului
        //aici trebuie facute niste validari
        if ($mimeType != "image/png" && $mimeType != "image/jpg" && $mimeType != "image/jpeg" && $mimeType != "video/mp4" && $mimeType != "video/m4v") //daca nu e de tip imagine sau video
            $upload = 0;
        if ($filesize > $fileLimitUpload)
            $upload = 0;
        
        if($upload){
            //trebuie incarcat in baza de date numele pozei . incarc in tabelul mesaje practic 
            $image = str_replace(' ','',$image);
            $sql = "INSERT INTO messages(userfrom, timestampp,content) VALUES ('$currentUser','$msgTimestamp','$image')";
            mysqli_query($conn, $sql);
            //upload-ul efectiv al pozei
            move_uploaded_file($tmpfilename, $filefolder . $image);
        }
        else 
            echo "Fisierul incarcat nu e fotografie sau depaseste 5MB";
        
    }

    //checking pt comenzi 
    if($_SESSION["userRank"] == 2){ //daca e moderator
        if(trim($msgContent) == '/clear'){
            $sql = "DELETE FROM `messages` WHERE 1";
            mysqli_query($conn, $sql);
        }
    }

    $sql = '';
    if(trim($msgContent) != '/clear')//daca nu e comanda clear
        //incarcam mesajul text
        $sql = "INSERT INTO messages(userfrom, timestampp,content) VALUES ('$currentUser','$msgTimestamp','$msgContent')";
    else {
        if($_SESSION["userRank"] == 2){//daca e si moderator
            //inseram un mesaj de atentionare
            $sql = "INSERT INTO messages(userfrom, timestampp,content) VALUES ('$currentUser','$msgTimestamp','chat-ul a avut wipe')";
            echo "Chat-ul a avut wipe. In caz ca dati refresh la browser mesajele vor disparea.";
        }
        else //daca nu e moderator
            $sql = "INSERT INTO messages(userfrom, timestampp,content) VALUES ('$currentUser','$msgTimestamp','$msgContent')";
    }
    try {
        mysqli_query($conn, $sql);
    } catch (Exception $th) {
        echo $th;
    }
?>