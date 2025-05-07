<?php // Am Anfang der Datei, z.B. index.php
require_once 'includes/check_session.php'; // Diese Zeile hinzufügen

$pageTitle = "Hauptmenü";
// Datenbankverbindung herstellen (angenommen, db_connect.php ist im 'includes' Ordner)
require_once 'includes/db_connect.php';
require_once 'includes/header.php'; // $pageTitle und Breadcrumbs werden im Header gesetzt/genutzt
?>

<h1>Übersicht der Hauptkategorien</h1>

<div class="content-box">
    <div class="content-box-header">
        <h2>Hauptmenüpunkte</h2>
    </div>
    <ul class="menu-liste">
        <?php
        $sql = "SELECT id, titel, beschreibung FROM hauptmenues ORDER BY id ASC"; // Sortierung nach ID oder Titel
        $result = $conn->query($sql);

        if ($result && $result->num_rows > 0) {
            while($row = $result->fetch_assoc()) {
                echo "<li>";
                echo "<a href='untermenue.php?hauptmenue_id=" . htmlspecialchars($row["id"]) . "'>" . htmlspecialchars($row["titel"]) . "</a>";
                if (!empty($row["beschreibung"])) {
                    echo "<p class='menu-beschreibung'>" . htmlspecialchars($row["beschreibung"]) . "</p>";
                }
                echo "</li>";
            }
        } else {
            echo "<li>Keine Hauptmenüpunkte gefunden.</li>";
        }
        ?>
    </ul>
</div>

<?php
require_once 'includes/footer.php';
// Datenbankverbindung schließen
if (isset($conn) && is_object($conn) && method_exists($conn, 'close')) {
    $conn->close();
}
?>