<?php
$servername = "localhost"; // Standard für XAMPP
$username = "root";        // Standard für XAMPP
$password = "";            // Standard für XAMPP (oft leer)
$dbname = "iso27001"; // **ERSETZE DAS MIT DEINEM DATENBANKNAMEN**

// Verbindung erstellen
$conn = new mysqli($servername, $username, $password, $dbname);

// Verbindung prüfen
if ($conn->connect_error) {
    die("Verbindung fehlgeschlagen: " . $conn->connect_error);
}
// Zeichensatz auf UTF-8 setzen für korrekte Darstellung von Umlauten etc.
$conn->set_charset("utf8mb4");
?>