<?php // filename: fragen.php
require_once 'includes/db_connect.php';

$hauptmenue_id = null;
$untermenue_id = null; // Wichtig: Standardmäßig auf null setzen

if (isset($_GET['hauptmenue_id']) && is_numeric($_GET['hauptmenue_id'])) {
    $hauptmenue_id = intval($_GET['hauptmenue_id']);
} else {
    header("Location: index.php?error=no_hauptmenue_selected");
    exit;
}

// Titel des Hauptmenüs holen
$sqlHauptmenueTitel = "SELECT titel FROM hauptmenues WHERE id = ?";
$stmtHauptmenueTitel = $conn->prepare($sqlHauptmenueTitel);
$hauptmenue_titel_text = "Unbekanntes Hauptmenü";
if ($stmtHauptmenueTitel) {
    $stmtHauptmenueTitel->bind_param("i", $hauptmenue_id);
    $stmtHauptmenueTitel->execute();
    $resultHauptmenueTitel = $stmtHauptmenueTitel->get_result();
    if ($resultHauptmenueTitel->num_rows > 0) {
        $hauptmenue_data = $resultHauptmenueTitel->fetch_assoc();
        $hauptmenue_titel_text = htmlspecialchars($hauptmenue_data['titel']);
    } else {
        header("Location: index.php?error=hauptmenue_not_found_for_fragen");
        exit;
    }
    $stmtHauptmenueTitel->close();
}

$untermenue_titel_text = null;
if (isset($_GET['untermenue_id']) && is_numeric($_GET['untermenue_id'])) {
    $untermenue_id = intval($_GET['untermenue_id']); // untermenue_id nur setzen, wenn sie auch übergeben wurde
    $sqlUntermenueTitel = "SELECT titel FROM untermenues WHERE id = ? AND hauptmenue_id = ?";
    $stmtUntermenueTitel = $conn->prepare($sqlUntermenueTitel);
    if ($stmtUntermenueTitel) {
        $stmtUntermenueTitel->bind_param("ii", $untermenue_id, $hauptmenue_id);
        $stmtUntermenueTitel->execute();
        $resultUntermenueTitel = $stmtUntermenueTitel->get_result();
        if ($resultUntermenueTitel->num_rows > 0) {
            $untermenue_data = $resultUntermenueTitel->fetch_assoc();
            $untermenue_titel_text = htmlspecialchars($untermenue_data['titel']);
        } else {
            // Ungültige untermenue_id für das gegebene Hauptmenü
            header("Location: untermenue.php?hauptmenue_id=" . $hauptmenue_id . "&error=invalid_untermenue");
            exit;
        }
        $stmtUntermenueTitel->close();
    }
}

$pageTitle = "Fragen: " . $hauptmenue_titel_text . ($untermenue_titel_text ? " &raquo; " . $untermenue_titel_text : "");
require_once 'includes/header.php';
?>

<h1>
    <?php
    echo "Fragen zu: " . $hauptmenue_titel_text;
    if ($untermenue_titel_text) {
        echo " &raquo; " . $untermenue_titel_text;
    }
    ?>
</h1>

<div class="back-link-container">
    <?php if ($untermenue_id): ?>
        <span class="back-link"><a href="untermenue.php?hauptmenue_id=<?php echo htmlspecialchars($hauptmenue_id); ?>">&laquo; Zurück zu den Untermenüs von "<?php echo $hauptmenue_titel_text; ?>"</a></span>
    <?php else: ?>
        <span class="back-link"><a href="index.php">&laquo; Zurück zum Hauptmenü</a></span>
    <?php endif; ?>
</div>

<div class="content-box">
    <div class="content-box-header">
        <h2>Verfügbare Fragen</h2>
    </div>
    <ul class="fragen-liste">
        <?php
        // MAX(a.id) AS antwort_id stellt sicher, dass wir nur wissen, OB eine Antwort existiert (nicht NULL),
        // nicht die spezifische ID der Antwort, falls es mehrere gäbe. GROUP BY ist wichtig.
        $sql = "SELECT f.id, f.frage, MAX(a.id) AS antwort_id
                FROM fragen f
                LEFT JOIN antworten a ON f.id = a.frage_id ";

        if ($untermenue_id !== null) {
            $sql .= "WHERE f.hauptmenue_id = ? AND f.untermenue_id = ? ";
        } else {
            // Fragen, die direkt dem Hauptmenü ohne spezifisches Untermenü zugeordnet sind
            $sql .= "WHERE f.hauptmenue_id = ? AND f.untermenue_id IS NULL ";
        }
        $sql .= "GROUP BY f.id, f.frage ORDER BY f.id ASC";

        $stmt = $conn->prepare($sql);

        if ($stmt === false) {
            echo "<li class='frage-item'>Fehler bei der Vorbereitung: " . htmlspecialchars($conn->error) . "</li>";
        } else {
            if ($untermenue_id !== null) {
                $stmt->bind_param("ii", $hauptmenue_id, $untermenue_id);
            } else {
                $stmt->bind_param("i", $hauptmenue_id);
            }
            $stmt->execute();
            $result = $stmt->get_result();

            if ($result->num_rows > 0) {
                while ($row = $result->fetch_assoc()) {
                    echo "<li class='frage-item'>";
                    echo "<span class='frage-text'>";
                    // Link zur (noch zu erstellenden) Antwortseite oder zum Aufklappen der Antwort
                    echo "<a href='antwort_anzeigen.php?frage_id=" . htmlspecialchars($row['id']) . "'>" . htmlspecialchars($row['frage']) . "</a>";
                    echo "</span>";

                    if ($row['antwort_id'] !== null) {
                        echo "<span class='status-icon beantwortet' title='Beantwortet'>&#10004;</span>"; // ✔
                    } else {
                        echo "<span class='status-icon unbeantwortet' title='Unbeantwortet'>&#10008;</span>"; // ✗
                    }
                    echo "</li>";
                }
            } else {
                echo "<li class='frage-item'>Für diesen Bereich wurden noch keine Fragen erstellt.</li>";
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