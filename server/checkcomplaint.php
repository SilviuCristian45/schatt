<?php
    require 'config.php';
    $complaintID = $_GET["complaintid"];
    echo $complaintID . '<br>';
    //selectam starea curenta a complaintului
    $sql = "SELECT done FROM contact WHERE id = '$complaintID'";
    $complaintState = mysqli_fetch_assoc(mysqli_query($conn, $sql));
    $complaintStateIs = $complaintState["done"];
    //echo !$complaintState["done"];

    $newComplaintState = 0;
    if ((int)$complaintState["done"] == 0)
        $newComplaintState = 1;

    $sql2 = "UPDATE contact SET done = '$newComplaintState' WHERE id = '$complaintID' ;";
    mysqli_query($conn, $sql2);
    header('Location: ../../complaints.php');
?>