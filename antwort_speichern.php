<?php // filename: antwort_speichern.php
require_once 'includes/check_session.php'; // Session-Prüfung und Start GANZ AM ANFANG
include 'includes/db_connect.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Validierung der Eingaben
    $frage_id_raw = isset($_POST['frage_id']) ? trim($_POST['frage_id']) : '';
    $antwort_text_raw = isset($_POST['neue_antwort_text']) ? trim($_POST['neue_antwort_text']) : '';

    if (empty($frage_id_raw) || !is_numeric($frage_id_raw)) {
        // Fehler: Keine oder ungültige frage_id
        // Baue den Redirect-URL zusammen, um Kontext beizubehalten
        $redirect_url = "index.php?error=invalid_data_at_save"; // Fallback
        if(isset($_POST['hauptmenue_id']) && is_numeric($_POST['hauptmenue_id'])) {
             $redirect_url = "fragen.php?hauptmenue_id=" . intval($_POST['hauptmenue_id']);
             if(isset($_POST['untermenue_id']) && is_numeric($_POST['untermenue_id'])) {
                 $redirect_url .= "&untermenue_id=" . intval($_POST['untermenue_id']);
             }
             $redirect_url .= "&error=invalid_data_at_save_q"; // Spezifischerer Fehler
        }
        header("Location: " . $redirect_url);
        exit;
    }

    if (empty($antwort_text_raw)) {
        // Fehler: Antworttext ist leer
        $frage_id_for_redirect = intval($frage_id_raw);
        $redirect_url = "antwort_anzeigen.php?frage_id=" . $frage_id_for_redirect . "&error=empty_antwort";
        header("Location: " . $redirect_url);
        exit;
    }

    $frage_id = intval($frage_id_raw);
    $antwort_text = $antwort_text_raw;
    
    // Ersteller aus der Session holen
    // Es ist wichtig, dass $_SESSION["username"] in login.php korrekt gesetzt wurde.
    $ersteller = isset($_SESSION["username"]) && !empty($_SESSION["username"]) ? $_SESSION["username"] : 'System'; // Fallback 'System', falls Username leer oder nicht gesetzt

    // Antwort in die Datenbank einfügen
    $sql = "INSERT INTO antworten (frage_id, antwort, ersteller) VALUES (?, ?, ?)";
    $stmt = $conn->prepare($sql);

    if ($stmt) {
        $stmt->bind_param("iss", $frage_id, $antwort_text, $ersteller);
        if ($stmt->execute()) {
            // Erfolgreich gespeichert
            $redirect_url = "antwort_anzeigen.php?frage_id=" . $frage_id . "&status=antwort_gespeichert";
            header("Location: " . $redirect_url);
            exit;
        } else {
            // Fehler beim Speichern
            $redirect_url = "antwort_anzeigen.php?frage_id=" . $frage_id . "&error=db_save_failed";
            header("Location: " . $redirect_url);
            exit;
        }
        // $stmt->close(); // Wird durch exit nicht erreicht
    } else {
        // Fehler bei der Vorbereitung des SQL-Statements
        $redirect_url = "antwort_anzeigen.php?frage_id=" . $frage_id . "&error=db_prepare_failed";
        header("Location: " . $redirect_url);
        exit;
    }
    // $conn->close(); // Wird durch exit nicht erreicht

} else {
    // Nicht per POST aufgerufen
    header("Location: index.php");
    exit;
}
?>