<?php
    // Unset all of the session variables.
    session_destroy();//distrugem sesiunea pe server
    $_SESSION = array();//desetam variabilele din sesiune

    //trebuie sters si cookie-ul generat in browser (care contine id-ul sesiunii)
    if (ini_get("session.use_cookies")) {
        $params = session_get_cookie_params();//luam path-ul,domeniul,caracteristicile cookie-ului
        setcookie(session_name("userid"), '', time() - 42000,
            $params["path"], $params["domain"],
            $params["secure"], $params["httponly"]
        );
    }
    //redirectam userul pe index (pe urma va fi redirectat pe login.php )
    header("Location: index.php");
?>