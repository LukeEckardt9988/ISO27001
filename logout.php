<?php // filename: logout.php
session_start(); // Session starten, um auf sie zugreifen zu können

// Alle Session-Variablen löschen
$_SESSION = array();

// Session-Cookie löschen, falls vorhanden
if (ini_get("session.use_cookies")) {
    $params = session_get_cookie_params();
    setcookie(session_name(), '', time() - 42000,
        $params["path"], $params["domain"],
        $params["secure"], $params["httponly"]
    );
}

// Session zerstören
session_destroy();

// Zur Login-Seite weiterleiten
header("location: login.php");
exit;
?>