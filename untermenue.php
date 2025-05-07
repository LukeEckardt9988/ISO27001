<?php // filename: untermenue.php
require_once 'includes/check_session.php'; // Session-Prüfung am Anfang
require_once 'includes/db_connect.php';

if (!isset($_GET['hauptmenue_id']) || !is_numeric($_GET['hauptmenue_id'])) {
    header("Location: index.php?error=invalid_hauptmenue");
    exit;
}
$hauptmenue_id = intval($_GET['hauptmenue_id']);

// Titel des Hauptmenüs für die Seite und Breadcrumbs holen
$sqlHauptmenueTitel = "SELECT titel FROM hauptmenues WHERE id = ?";
$stmtHauptmenueTitel = $conn->prepare($sqlHauptmenueTitel);
$hauptmenue_titel_text = "Untermenüs"; // Fallback
$pageTitle = "Untermenüs";

// Variablen für Breadcrumbs im Header (aus header.php) initialisieren
$hauptmenue_id_fuer_breadcrumb = $hauptmenue_id;
$untermenue_id_fuer_breadcrumb = null;
$hauptmenue_titel_fuer_breadcrumb = '';
$untermenue_titel_fuer_breadcrumb = '';
$frage_titel_fuer_breadcrumb = '';


if ($stmtHauptmenueTitel) {
    $stmtHauptmenueTitel->bind_param("i", $hauptmenue_id);
    $stmtHauptmenueTitel->execute();
    $resultHauptmenueTitel = $stmtHauptmenueTitel->get_result();
    if ($resultHauptmenueTitel->num_rows > 0) {
        $hauptmenue_data = $resultHauptmenueTitel->fetch_assoc();
        $hauptmenue_titel_text = htmlspecialchars($hauptmenue_data['titel']);
        $pageTitle = "Untermenüs für: " . $hauptmenue_titel_text;
        $hauptmenue_titel_fuer_breadcrumb = $hauptmenue_titel_text;
    } else {
        header("Location: index.php?error=hauptmenue_not_found_for_untermenue");
        exit;
    }
    $stmtHauptmenueTitel->close();
} else {
    die("Fehler bei der Vorbereitung der Hauptmenü-Titel-Abfrage: " . $conn->error);
}

include 'includes/header.php';
?>



<h1><?php echo "Unterkategorien für: " . $hauptmenue_titel_text; ?></h1>
<div class="back-link-container">
<span class="back-link"><a href="index.php">&laquo; Zurück zum Hauptmenü</a></span>

</div>
<div class="content-box">
    <div class="content-box-header">
        <h2>Verfügbare Untermenüs</h2>
    </div>
    <ul class="menu-liste untermenue-liste">
        <?php
        $sql = "SELECT 
                    um.id, 
                    um.titel,
                    COUNT(f.id) AS total_fragen,
                    COUNT(DISTINCT CASE WHEN a.id IS NOT NULL THEN f.id ELSE NULL END) AS beantwortete_fragen
                FROM untermenues um
                LEFT JOIN fragen f ON um.id = f.untermenue_id AND f.hauptmenue_id = um.hauptmenue_id
                LEFT JOIN antworten a ON f.id = a.frage_id
                WHERE um.hauptmenue_id = ?
                GROUP BY um.id, um.titel
                ORDER BY um.id ASC";

        $stmt = $conn->prepare($sql);

        if ($stmt === false) {
            echo "<li class='menu-item-error'>Fehler beim Laden der Untermenüs: " . htmlspecialchars($conn->error) . "</li>";
        } else {
            $stmt->bind_param("i", $hauptmenue_id);
            $stmt->execute();
            $result = $stmt->get_result();

            $untermenues_angezeigt = false;
            if ($result->num_rows > 0) {
                $untermenues_angezeigt = true;
                while($row = $result->fetch_assoc()) {
                    echo "<li class='menu-item'>";
                    echo "<a href='fragen.php?hauptmenue_id=" . htmlspecialchars($hauptmenue_id) . "&untermenue_id=" . htmlspecialchars($row["id"]) . "'>" . htmlspecialchars($row["titel"]) . "</a>";
                    
                    // Mini-Fortschrittsbalken für das Untermenü
                    echo "<div class='submenu-progress-indicator'>";
                    if ($row['total_fragen'] > 0) {
                        $prozent_erledigt = ($row['beantwortete_fragen'] / $row['total_fragen']) * 100;
                        $progress_class = 'empty'; // Standard: leer
                        if ($prozent_erledigt == 100) {
                            $progress_class = 'full';
                        } elseif ($prozent_erledigt > 0) {
                            $progress_class = 'partial';
                        }
                        echo "<div class='mini-progress-bar-container' title='" . htmlspecialchars($row['beantwortete_fragen'] . ' von ' . $row['total_fragen'] . ' Fragen beantwortet') . "'>";
                        echo "<div class='mini-progress-bar-fill " . $progress_class . "' style='width: " . round($prozent_erledigt) . "%;'></div>";
                        echo "</div>";
                    } else {
                        // Keine Fragen in diesem Untermenü, evtl. Platzhalter oder nichts
                        echo "<div class='mini-progress-bar-container no-questions' title='Keine Fragen vorhanden'>";
                        echo "<div class='mini-progress-bar-fill empty' style='width: 100%;'></div>"; // Voller leerer Balken
                        echo "</div>";
                    }
                    echo "</div>"; // Ende .submenu-progress-indicator
                    echo "</li>";
                }
            }

            // Link für Fragen, die direkt dem Hauptmenü zugeordnet sind
            $sqlDirekteFragen = "SELECT 
                                    COUNT(f.id) AS total_direkte_fragen,
                                    COUNT(DISTINCT CASE WHEN a.id IS NOT NULL THEN f.id ELSE NULL END) AS beantwortete_direkte_fragen
                                 FROM fragen f
                                 LEFT JOIN antworten a ON f.id = a.frage_id
                                 WHERE f.hauptmenue_id = ? AND f.untermenue_id IS NULL";
            $stmtDirekteFragen = $conn->prepare($sqlDirekteFragen);
            if ($stmtDirekteFragen) {
                $stmtDirekteFragen->bind_param("i", $hauptmenue_id);
                $stmtDirekteFragen->execute();
                $resultDirekteFragen = $stmtDirekteFragen->get_result();
                $direkteFragenInfo = $resultDirekteFragen->fetch_assoc();
                $stmtDirekteFragen->close();

                if ($direkteFragenInfo && $direkteFragenInfo['total_direkte_fragen'] > 0) {
                    $untermenues_angezeigt = true;
                    echo "<li class='menu-item'>";
                    echo "<a href='fragen.php?hauptmenue_id=" . htmlspecialchars($hauptmenue_id) . "'>Allgemeine Fragen zu \"" . $hauptmenue_titel_text . "\"</a>";
                    
                    echo "<div class='submenu-progress-indicator'>";
                    $prozent_erledigt_direkt = ($direkteFragenInfo['beantwortete_direkte_fragen'] / $direkteFragenInfo['total_direkte_fragen']) * 100;
                    $progress_class_direkt = 'empty';
                    if ($prozent_erledigt_direkt == 100) {
                        $progress_class_direkt = 'full';
                    } elseif ($prozent_erledigt_direkt > 0) {
                        $progress_class_direkt = 'partial';
                    }
                    echo "<div class='mini-progress-bar-container' title='" . htmlspecialchars($direkteFragenInfo['beantwortete_direkte_fragen'] . ' von ' . $direkteFragenInfo['total_direkte_fragen'] . ' Fragen beantwortet') . "'>";
                    echo "<div class='mini-progress-bar-fill " . $progress_class_direkt . "' style='width: " . round($prozent_erledigt_direkt) . "%;'></div>";
                    echo "</div>";
                    echo "</div>"; // Ende .submenu-progress-indicator
                    echo "</li>";
                }
            }

            if (!$untermenues_angezeigt && ( !$direkteFragenInfo || $direkteFragenInfo['total_direkte_fragen'] == 0) ) {
                 echo "<li class='menu-item-info'>Für diesen Bereich gibt es aktuell keine spezifischen Untermenüs oder direkten Fragen.</li>";
            }
            $stmt->close();
        }
        ?>
    </ul>
</div>

<?php
require_once 'includes/footer.php';
if (isset($conn) && is_object($conn) && method_exists($conn, 'close')) {
    $conn->close();
}
?>
