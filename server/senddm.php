<?php
    require 'config.php';
    session_start();

    $currentUser = $_SESSION["userid"];
    $msgUser = $_POST["new_user"];
    $msgContent = $_POST["message"];
    $msgTimestamp = $_POST["timestampp"];
    
    if (isset($_FILES["fileToUpload"])) {//daca s-a incarcat o imagine
        $image = $_FILES["fileToUpload"]["name"];
        $filefolder = '../uploads/';   //stochez path-ul folder-ului unde incarc fisierul
        $tmpfilename = $_FILES["fileToUpload"]["tmp_name"];     //fisierul inainte de upload va fi mutat intr-un folder temporar
        $filesize = $_FILES["fileToUpload"]["size"];    //marimea in bytes
        
        $upload = 1;// pp ca putem sa uploadam poza pe server
        $fileLimitUpload = 7000000; //limita de 5 mb per poza

        $mimeType = mime_content_type($tmpfilename);//stochez MIME type-ul fisierului
        //aici trebuie facute niste validari
        if ($mimeType != "image/png" && $mimeType != "image/jpg" && $mimeType != "image/jpeg" && $mimeType != "video/mp4" && $mimeType != "video/m4v")//daca nu e de tip imagine
            $upload = 0;
        if ($filesize > $fileLimitUpload)
            $upload = 0;
        
        if ($upload) {
            //trebuie incarcat in baza de date numele pozei . incarc in tabelul mesaje practic 
            $image = str_replace(' ','',$image);
            $sql = "INSERT INTO direct_messages(userfrom, userto, timestampp,content) VALUES ('$currentUser','$msgUser','$msgTimestamp','$image')";
            mysqli_query($conn, $sql);
            //upload-ul efectiv al pozei
            move_uploaded_file($tmpfilename, $filefolder . $image);
        }
        else 
            echo "Fisierul incarcat nu e fotografie sau depaseste 5MB";
    }

    $auxiliarUsername = $msgUser;

    if((int)$msgUser == 0) //daca mi se transmite un nume in loc de id pt user-ul la care se trimite dm-ul
        $msgUser = getidRecord($conn , "users" , "username" , $msgUser) or die("Acest utilizator nu exista pe chat. ");
    //luam id-ul userului cu numele dat in formular 
    $sql = "INSERT INTO `direct_messages`(`userfrom`, `userto`, `timestampp`, `content`) VALUES ('$currentUser','$msgUser','$msgTimestamp','$msgContent')";
    try {
        mysqli_query($conn, $sql);
        if ((int)$auxiliarUsername == 0) //daca a fost introdus un nume in pagina de create conversation
            echo "Conversatie creata cu succes. Click pe sectiunea direct messages pentru a deschide conversatia";
    } catch (Exception $th) {
        echo $th;
    }


    //returns the id (int) of record with given fieldname value from a given table
    function getidRecord($connection, $tablename , $fieldname , $fieldvalue){
        $sql = "SELECT id FROM " . $tablename . " WHERE " . $fieldname . " = '". $fieldvalue . "'";
        $result = mysqli_fetch_assoc(mysqli_query($connection,$sql));
        return $result["id"];
    }
?>