<?php
// GANZ AM ANFANG: Session-Prüfung und Start
require_once 'includes/check_session.php';
// Datenbankverbindung einbinden
include 'includes/db_connect.php';

// Status- und Fehlermeldungen werden jetzt NACH dem Header ausgegeben
$status_message = '';
$error_message_display = '';

if (isset($_GET['status']) && $_GET['status'] == 'antwort_gespeichert') {
    $status_message = "<div class='alert alert-success' style='background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; padding: 10px; margin-bottom: 15px; border-radius: 4px;'>Deine Antwort wurde erfolgreich gespeichert!</div>";
}
if (isset($_GET['error'])) {
    $tempErrorMessage = "Ein Fehler ist aufgetreten.";
    if ($_GET['error'] == 'empty_antwort') {
        $tempErrorMessage = "Der Antworttext darf nicht leer sein.";
    } elseif ($_GET['error'] == 'db_save_failed') {
        $tempErrorMessage = "Die Antwort konnte nicht in der Datenbank gespeichert werden.";
    } elseif ($_GET['error'] == 'db_prepare_failed') {
        $tempErrorMessage = "Ein Datenbankfehler ist aufgetreten (Vorbereitung).";
    } elseif ($_GET['error'] == 'frage_not_found' || $_GET['error'] == 'invalid_frage_id') {
        $tempErrorMessage = "Die angeforderte Frage konnte nicht gefunden werden.";
    }
    $error_message_display = "<div class='alert alert-danger' style='background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; padding: 10px; margin-bottom: 15px; border-radius: 4px;'>" . htmlspecialchars($tempErrorMessage) . "</div>";
}

$frage_id = 0;
if (isset($_GET['frage_id']) && is_numeric($_GET['frage_id'])) {
    $frage_id = intval($_GET['frage_id']);
} else {
    header("Location: index.php?error=invalid_frage_id");
    exit;
}

$sqlFrage = "SELECT f.id AS frage_id, f.frage AS fragetext, f.hauptmenue_id, hm.titel AS hauptmenue_titel, um.id AS untermenue_id, um.titel AS untermenue_titel
             FROM fragen f
             JOIN hauptmenues hm ON f.hauptmenue_id = hm.id
             LEFT JOIN untermenues um ON f.untermenue_id = um.id
             WHERE f.id = ?";
$stmtFrage = $conn->prepare($sqlFrage);
$pageTitle = "Antwort anzeigen";
$frageDetails = null;

$hauptmenue_id_fuer_breadcrumb = null;
$untermenue_id_fuer_breadcrumb = null;
$hauptmenue_titel_fuer_breadcrumb = '';
$untermenue_titel_fuer_breadcrumb = '';
$frage_titel_fuer_breadcrumb = '';

if ($stmtFrage) {
    $stmtFrage->bind_param("i", $frage_id);
    $stmtFrage->execute();
    $resultFrage = $stmtFrage->get_result();
    if ($resultFrage->num_rows > 0) {
        $frageDetails = $resultFrage->fetch_assoc();
        $pageTitle = "Antwort für: \"" . htmlspecialchars(substr($frageDetails['fragetext'], 0, 50)) . "...\"";
        
        $frage_titel_fuer_breadcrumb = htmlspecialchars($frageDetails['fragetext']);
        $hauptmenue_id_fuer_breadcrumb = $frageDetails['hauptmenue_id'];
        $untermenue_id_fuer_breadcrumb = $frageDetails['untermenue_id'];
        $hauptmenue_titel_fuer_breadcrumb = htmlspecialchars($frageDetails['hauptmenue_titel']);
        if ($frageDetails['untermenue_titel']) {
            $untermenue_titel_fuer_breadcrumb = htmlspecialchars($frageDetails['untermenue_titel']);
        }
    } else {
        header("Location: index.php?error=frage_not_found");
        exit;
    }
    $stmtFrage->close();
} else {
    die("Fehler bei der Vorbereitung der Frage-Abfrage: " . $conn->error);
}

include 'includes/header.php'; // $pageTitle und Breadcrumb-Variablen sind jetzt gesetzt
?>

<div class="container main-content">
    <?php 
    if (!empty($status_message)) echo $status_message;
    if (!empty($error_message_display)) echo $error_message_display;
    ?>

    <?php if ($frageDetails): ?>
        <div class="frage-container">
            <small class="breadcrumbs">
                <a href="index.php">Hauptmenü</a> &raquo;
                <a href="untermenue.php?hauptmenue_id=<?php echo htmlspecialchars($frageDetails['hauptmenue_id']); ?>">
                    <?php echo htmlspecialchars($frageDetails['hauptmenue_titel']); ?>
                </a>
                <?php if ($frageDetails['untermenue_id']): ?>
                    &raquo; <a href="fragen.php?hauptmenue_id=<?php echo htmlspecialchars($frageDetails['hauptmenue_id']); ?>&untermenue_id=<?php echo htmlspecialchars($frageDetails['untermenue_id']); ?>">
                        <?php echo htmlspecialchars($frageDetails['untermenue_titel']); ?>
                    </a>
                <?php else: ?>
                    &raquo; <a href="fragen.php?hauptmenue_id=<?php echo htmlspecialchars($frageDetails['hauptmenue_id']); ?>">
                        (Direkte Fragen)
                    </a>
                <?php endif; ?>
            </small>
            <h2>Frage:</h2>
            <p class="frage-text-gross"><?php echo nl2br(htmlspecialchars($frageDetails['fragetext'])); ?></p>
        </div>

        <hr>

        <h3>Antwort(en):</h3>
        <div class="antworten-liste">
            <?php
            $sqlAntworten = "SELECT id, antwort, ersteller, DATE_FORMAT(erstellungsdatum, '%d.%m.%Y um %H:%i Uhr') AS erstellungsdatum_formatiert
                             FROM antworten
                             WHERE frage_id = ?
                             ORDER BY erstellungsdatum DESC";
            $stmtAntworten = $conn->prepare($sqlAntworten);

            if ($stmtAntworten) {
                $stmtAntworten->bind_param("i", $frage_id);
                $stmtAntworten->execute();
                $resultAntworten = $stmtAntworten->get_result();

                if ($resultAntworten->num_rows > 0) {
                    while ($antwort = $resultAntworten->fetch_assoc()) {
                        echo "<div class='antwort-item'>";
                        echo "<p class='antwort-text'>" . nl2br(htmlspecialchars($antwort['antwort'])) . "</p>";
                        echo "<p class='antwort-meta'>";
                        if (!empty($antwort['ersteller'])) {
                            echo "Erstellt von: <strong>" . htmlspecialchars($antwort['ersteller']) . "</strong>";
                        } else {
                            echo "Erstellt von: <strong>Anonym</strong>"; // Dieser Fall sollte seltener werden
                        }
                        echo " am " . htmlspecialchars($antwort['erstellungsdatum_formatiert']);
                        echo "</p>";
                        echo "</div><hr class='antwort-trenner'>";
                    }
                } else {
                    echo "<p>Für diese Frage wurde noch keine Antwort hinterlegt.</p>";
                }
                $stmtAntworten->close();
            } else {
                echo "<p>Fehler beim Laden der Antworten: " . htmlspecialchars($conn->error) . "</p>";
            }
            ?>
        </div>

        <div class="neue-antwort-bereich">
            <hr>
            <h3>Eine neue Antwort schreiben:</h3>
            <form action="antwort_speichern.php" method="POST">
                <input type="hidden" name="frage_id" value="<?php echo htmlspecialchars($frage_id); ?>">
                <input type="hidden" name="hauptmenue_id" value="<?php echo htmlspecialchars($frageDetails['hauptmenue_id']); ?>">
                <?php if ($frageDetails['untermenue_id']): ?>
                    <input type="hidden" name="untermenue_id" value="<?php echo htmlspecialchars($frageDetails['untermenue_id']); ?>">
                <?php endif; ?>

                <div>
                    <label for="neue_antwort_text">Deine Antwort:</label><br>
                    <textarea id="neue_antwort_text" name="neue_antwort_text" placeholder="Beschreiben Sie den Ist-Zustand. Wenn Verbesserungen geplant sind, beschreiben Sie diese (inkl. Verantwortlichkeiten und Zeitrahmen für die Umsetzung)."  rows="10" cols="70" required></textarea>
                </div>
                
                <div style="margin-top:15px;">
                    <button type="submit">Antwort speichern</button>
                </div>
            </form>
        </div>

        <p style="margin-top: 20px;">
            <?php
            $zurueck_url = "fragen.php?hauptmenue_id=" . htmlspecialchars($frageDetails['hauptmenue_id']);
            if ($frageDetails['untermenue_id']) {
                $zurueck_url .= "&untermenue_id=" . htmlspecialchars($frageDetails['untermenue_id']);
            }
            ?>
            <a href="<?php echo $zurueck_url; ?>">&laquo; Zurück zur Fragenübersicht</a>
        </p>

    <?php else: ?>
        <p>Die angeforderte Frage konnte nicht gefunden werden.</p>
        <p><a href="index.php">&laquo; Zurück zur Startseite</a></p>
    <?php endif; ?>
</div>

<?php
include 'includes/footer.php';
if (isset($conn) && is_object($conn) && method_exists($conn, 'close')) {
    $conn->close();
}
?>