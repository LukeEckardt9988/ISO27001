<?php // filename: includes/header.php
// Stellen Sie sicher, dass die Session gestartet ist, falls noch nicht geschehen
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// --- PHP-Logik für das PDF-Dropdown-Menü ---
$pdf_directory = 'pdf_downloads/'; // Name des Ordners, in dem Ihre PDFs liegen
$pdf_files = []; // Array zum Speichern der gefundenen PDF-Dateinamen
$pdf_display_names = []; // Array für "schönere" Anzeigenamen

// Prüfen, ob das Verzeichnis existiert
if (is_dir($pdf_directory)) {
    // Alle Dateien im Verzeichnis scannen
    $files_in_dir = scandir($pdf_directory);
    if ($files_in_dir !== false) {
        foreach ($files_in_dir as $file) {
            // Voller Pfad zur Datei
            $file_path = $pdf_directory . $file;
            // Nur reguläre Dateien mit der Endung .pdf berücksichtigen
            if (is_file($file_path) && strtolower(pathinfo($file_path, PATHINFO_EXTENSION)) == 'pdf') {
                $pdf_files[] = $file; // Dateinamen zur Liste hinzufügen
                // Einen lesbareren Namen für die Anzeige erstellen:
                // Ersetzt Unterstriche durch Leerzeichen, entfernt die .pdf-Endung, macht Anfangsbuchstaben groß.
                $display_name = ucwords(str_replace(['_', '-'], ' ', pathinfo($file, PATHINFO_FILENAME)));
                $pdf_display_names[$file] = $display_name;
            }
        }
    }
}
// --- Ende PDF-Dropdown-Logik ---

// Ihre bestehenden Variablen für den Seitentitel, Logo etc.
$current_page_title = isset($pageTitle) ? htmlspecialchars($pageTitle) : "ISO27001 Portal";
$logo_text = "ISO27001 FAQ"; // Oder wie Sie es definiert haben

// Ihre bestehende Breadcrumb-Logik (hier nicht gezeigt, aber sie bleibt erhalten)
// $breadcrumbs = []; ...
?>
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo $current_page_title; ?></title>
    <link rel="stylesheet" href="css/style.css">
    </head>
<body>
    <header class="app-header">
        <div class="container">
            <div class="logo">
                <a href="index.php"><?php echo htmlspecialchars($logo_text); ?></a>
            </div>

            <nav class="header-nav"> 
                <?php // Dropdown-Menü für PDFs, nur anzeigen, wenn PDFs gefunden wurden ?>
                <?php if (!empty($pdf_files)): ?>
                    <div class="dropdown">
                        <button class="dropdown-toggle" type="button" aria-haspopup="true" aria-expanded="false">
                            Download<span class="dropdown-arrow">&#9662;</span> 
                        </button>
                        <ul class="dropdown-menu" role="menu">
                            <?php foreach ($pdf_files as $pdf_filename): ?>
                                <li role="none">
                                    <a role="menuitem"
                                       href="<?php echo htmlspecialchars($pdf_directory . rawurlencode($pdf_filename)); ?>"
                                       download="<?php echo htmlspecialchars($pdf_filename); ?>">
                                        <?php echo htmlspecialchars($pdf_display_names[$pdf_filename]); ?>
                                    </a>
                                </li>
                            <?php endforeach; ?>
                        </ul>
                    </div>
                <?php endif; ?>

                <?php // Bereich für Benutzerinformationen und Logout-Button ?>
                <div class="header-actions">
                    <?php if (isset($_SESSION["loggedin"]) && $_SESSION["loggedin"] === true && isset($_SESSION["username"])): ?>
                        <span class="user-greeting" style="color: #e0e0e0; margin-right: 15px; font-size: 0.9em;">
                            Angemeldet als: <strong><?php echo htmlspecialchars($_SESSION["username"]); ?></strong>
                        </span>
                        <a href="logout.php" class="logout-button" style="color: #1bbaa4; text-decoration: none; font-weight: bold; font-size: 0.9em; padding: 7px 14px; border: 1px solid #1bbaa4; border-radius: 4px; transition: background-color 0.2s, color 0.2s;">
                            Abmelden
                        </a>
                    <?php endif; ?>
                </div>
            </nav>
        </div>
    </header>

    <?php // Ihre bestehende Breadcrumb-Navigation, falls vorhanden ?>
    <?php if (!empty($breadcrumbs)): ?>
    <nav class="breadcrumbs-nav">
        <div class="container">
            <ul class="breadcrumb-list">
                <?php foreach ($breadcrumbs as $index => $crumb): ?>
                    <li>
                        <?php
                        $isLastElement = ($index === count($breadcrumbs) - 1);
                        if (isset($crumb['url']) && !$isLastElement): ?>
                            <a href="<?php echo htmlspecialchars($crumb['url']); ?>"><?php echo htmlspecialchars($crumb['text']); ?></a>
                        <?php else: ?>
                            <?php echo htmlspecialchars($crumb['text']); ?>
                        <?php endif; ?>
                        <?php if (!$isLastElement): ?>
                            <span class="breadcrumb-separator">&raquo;</span>
                        <?php endif; ?>
                    </li>
                <?php endforeach; ?>
            </ul>
        </div>
    </nav>
    <?php endif; ?>

    <main class="page-content-wrapper">
        <div class="container">