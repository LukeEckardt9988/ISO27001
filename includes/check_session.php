<?php // filename: includes/check_session.php
// Sicherstellen, dass die Session gestartet wird, falls noch nicht geschehen
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// Prüfen, ob der Benutzer eingeloggt ist, ansonsten zur Login-Seite weiterleiten
if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true) {
    // Optional: Den ursprünglichen Pfad speichern, um nach dem Login dorthin zurückzuleiten
    // $_SESSION['redirect_url'] = $_SERVER['REQUEST_URI'];
    header("location: login.php");
    exit;
}
?>