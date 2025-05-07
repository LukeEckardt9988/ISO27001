<?php // filename: includes/footer.php

// PHP-Logik zur Berechnung des Fortschritts
// Diese Logik sollte idealerweise Zugriff auf die Datenbankverbindung $conn haben.
// Stellen Sie sicher, dass db_connect.php vorher eingebunden wurde und $conn verfügbar ist.

$total_fragen = 0;
$beantwortete_fragen = 0;
$prozent_beantwortet_formatiert = "0.00"; // Standardwert

if (isset($conn) && $conn) { // Prüfen, ob die DB-Verbindung existiert
    // 1. Gesamtzahl aller Fragen ermitteln
    $sql_total = "SELECT COUNT(*) AS total FROM fragen";
    $result_total = $conn->query($sql_total);
    if ($result_total && $result_total->num_rows > 0) {
        $row_total = $result_total->fetch_assoc();
        $total_fragen = (int)$row_total['total'];
    }

    // 2. Anzahl der Fragen ermitteln, die mindestens eine Antwort haben
    $sql_beantwortet = "SELECT COUNT(DISTINCT frage_id) AS beantwortet FROM antworten";
    $result_beantwortet = $conn->query($sql_beantwortet);
    if ($result_beantwortet && $result_beantwortet->num_rows > 0) {
        $row_beantwortet = $result_beantwortet->fetch_assoc();
        $beantwortete_fragen = (int)$row_beantwortet['beantwortet'];
    }

    // 3. Prozentsatz berechnen
    if ($total_fragen > 0) {
        $prozent_beantwortet = ($beantwortete_fragen / $total_fragen) * 100;
        $prozent_beantwortet_formatiert = number_format($prozent_beantwortet, 2, ',', '.');
    } else {
        $prozent_beantwortet = 0; // Falls keine Fragen vorhanden sind
    }
} else {
    // Fallback, falls keine DB-Verbindung besteht (sollte nicht passieren, wenn db_connect.php korrekt eingebunden ist)
    $prozent_beantwortet = 0;
    // Optional: Fehlermeldung für Entwickler
    // error_log("Datenbankverbindung in footer.php nicht verfügbar für Fortschrittsbalken.");
}

?>
        </div> </main> <footer class="app-footer">
        <div class="container">
            <?php if ($total_fragen > 0): // Fortschrittsbalken nur anzeigen, wenn es Fragen gibt ?>
            <div class="progress-container">
                <div class="progress-bar-label">
                    <span>Fortschritt der Beantwortung:</span>
                    <span class="progress-percentage"><?php echo $prozent_beantwortet_formatiert; ?>%</span>
                </div>
                <div class="progress-bar-background">
                    <div class="progress-bar-fill" style="width: <?php echo round($prozent_beantwortet, 2); ?>%;" title="<?php echo $beantwortete_fragen . ' von ' . $total_fragen . ' Fragen beantwortet'; ?>">
                        <?php // Optional: Text im Balken, wenn gewünscht und Platz ist ?>
                        <?php /* if ($prozent_beantwortet > 10) { echo round($prozent_beantwortet, 0) . '%'; } */ ?>
                    </div>
                </div>
            </div>
            <?php endif; ?>

            <p class="copyright-text">&copy; <?php echo date("Y"); ?> EPSa. Alle Rechte vorbehalten.</p>
        </div>
    </footer>

</body>
</html>
<?php
// Die Datenbankverbindung wird normalerweise am Ende des Hauptskripts geschlossen,
// das footer.php einbindet (z.B. in index.php, fragen.php etc.).
// Daher ist $conn->close(); hier meist nicht nötig oder sogar schon zu spät.
?>