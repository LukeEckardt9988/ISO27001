<?php // filename: untermenue.php
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
if ($stmtHauptmenueTitel) {
    $stmtHauptmenueTitel->bind_param("i", $hauptmenue_id);
    $stmtHauptmenueTitel->execute();
    $resultHauptmenueTitel = $stmtHauptmenueTitel->get_result();
    if ($resultHauptmenueTitel->num_rows > 0) {
        $hauptmenue_data = $resultHauptmenueTitel->fetch_assoc();
        $hauptmenue_titel_text = htmlspecialchars($hauptmenue_data['titel']);
    } else {
        // Hauptmenü nicht gefunden, vielleicht zur Indexseite leiten oder Fehler anzeigen
        header("Location: index.php?error=hauptmenue_not_found");
        exit;
    }
    $stmtHauptmenueTitel->close();
}
$pageTitle = "Untermenüs: " . $hauptmenue_titel_text;
require_once 'includes/header.php'; // Header nach Setzen von $pageTitle und $hauptmenue_titel_text
?>

<h1><?php echo "Unterkategorien für: " . $hauptmenue_titel_text; ?></h1>

<div class="back-link-container">
    <span class="back-link"><a href="index.php">&laquo; Zurück zum Hauptmenü</a></span>
</div>

<div class="content-box">
    <div class="content-box-header">
        <h2>Verfügbare Untermenüs</h2>
    </div>
    <ul class="menu-liste">
        <?php
        $sql = "SELECT id, titel FROM untermenues WHERE hauptmenue_id = ? ORDER BY id ASC"; // Sortierung nach ID oder Titel
        $stmt = $conn->prepare($sql);

        if ($stmt === false) {
            echo "<li>Fehler beim Laden der Untermenüs: " . htmlspecialchars($conn->error) . "</li>";
        } else {
            $stmt->bind_param("i", $hauptmenue_id);
            $stmt->execute();
            $result = $stmt->get_result();

            $untermenues_gefunden = false;
            if ($result->num_rows > 0) {
                $untermenues_gefunden = true;
                while($row = $result->fetch_assoc()) {
                    echo "<li>";
                    echo "<a href='fragen.php?hauptmenue_id=" . htmlspecialchars($hauptmenue_id) . "&untermenue_id=" . htmlspecialchars($row["id"]) . "'>" . htmlspecialchars($row["titel"]) . "</a>";
                    echo "</li>";
                }
            }
            $stmt->close();

            // Prüfen, ob es Fragen direkt unter dem Hauptmenü gibt (ohne Untermenü)
            $sqlCheckFragen = "SELECT id FROM fragen WHERE hauptmenue_id = ? AND untermenue_id IS NULL LIMIT 1";
            $stmtCheckFragen = $conn->prepare($sqlCheckFragen);
            $fragen_direkt_gefunden = false;
            if ($stmtCheckFragen) {
                $stmtCheckFragen->bind_param("i", $hauptmenue_id);
                $stmtCheckFragen->execute();
                $resultCheckFragen = $stmtCheckFragen->get_result();
                if ($resultCheckFragen->num_rows > 0) {
                    $fragen_direkt_gefunden = true;
                    echo "<li><a href='fragen.php?hauptmenue_id=" . htmlspecialchars($hauptmenue_id) . "'>Allgemeine Fragen zu \"" . $hauptmenue_titel_text . "\" anzeigen</a></li>";
                }
                $stmtCheckFragen->close();
            }

            if (!$untermenues_gefunden && !$fragen_direkt_gefunden) {
                 echo "<li>Für diesen Bereich gibt es aktuell keine spezifischen Untermenüs oder direkten Fragen.</li>";
            }
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