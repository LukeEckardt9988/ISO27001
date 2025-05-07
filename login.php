<?php // filename: login.php
session_start(); // Session starten oder fortsetzen

// Wenn der Benutzer bereits eingeloggt ist, zur Startseite weiterleiten
if (isset($_SESSION['loggedin']) && $_SESSION['loggedin'] === true) {
    header("location: index.php");
    exit;
}

// Hartcodierte Anmeldedaten (NICHT FÜR PRODUKTION!)
define('VALID_PASSWORD', '27001');

$username_eingabe = ""; // Variable für das Benutzernamensfeld
$password_eingabe = "";
$login_err = "";

// Formularverarbeitung, wenn Daten gesendet wurden
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (empty(trim($_POST["username"]))) {
        $login_err = "Bitte geben Sie einen Benutzernamen ein.";
    } else {
        $username_eingabe = trim($_POST["username"]);
    }

    if (empty(trim($_POST["password"]))) {
        $login_err = "Bitte geben Sie Ihr Passwort ein.";
    } else {
        $password_eingabe = trim($_POST["password"]);
    }

    if (empty($login_err)) {
        if ($password_eingabe === VALID_PASSWORD) {
            $_SESSION["loggedin"] = true;
            $_SESSION["username"] = $username_eingabe;
            header("location: index.php");
            exit;
        } else {
            $login_err = "Ungültiges Passwort.";
        }
    }
}
?>
<!DOCTYPE html>
<html lang="de">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - ISO27001 Informationsportal</title>
    <link rel="stylesheet" href="css/style.css"> <?php /* Ihre bestehende style.css wird weiterhin für generelle Elemente genutzt, falls nicht hier überschrieben */ ?>
    <style>
        /* Spezifische Stile für die Login-Seite */
        body.login-page {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            background-color: #00695c;
            /* Dunkleres Grün, abgeleitet von #00796b */
            padding: 20px;
            color: #f0f0f0;
            /* Hellerer Standardtext für den Body, falls etwas außerhalb der Box landet */
        }

        .login-wrapper {
            width: 100%;
            display: flex;
            justify-content: center;
        }

        .login-container {
            background-color: #ffffff;
            /* Die Login-Box bleibt weiß für Kontrast */
            padding: 35px 45px;
            /* Etwas mehr Padding */
            border-radius: 8px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
            /* Stärkerer Schatten für mehr Tiefe */
            width: 100%;
            max-width: 700px;
            /* Etwas breiter für den Textblock */
            color: #4a4a4a;
            /* Textfarbe innerhalb der weißen Box */
        }

        .login-container h1 {
            color: #2a3539;
            text-align: center;
            margin-top: 0;
            margin-bottom: 10px;
            font-size: 2em;
            /* Größerer Haupttitel */
        }

        .login-container h2.portal-title {
            color: #00796b;
            /* Teal-Farbe für den Untertitel */
            text-align: center;
            margin-bottom: 30px;
            font-size: 1.4em;
            font-weight: 600;
            /* Etwas fetter */
        }

        /* Überarbeiteter Beschreibungsblock */
        .login-description {
            margin-bottom: 30px;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.1);
            /* Sehr subtiler, heller Overlay auf dem grünen Hintergrund */
            border: 1px solid rgba(255, 255, 255, 0.2);
            /* Subtile helle Border */
            border-radius: 6px;
            font-size: 0.98em;
            /* Etwas größer für bessere Lesbarkeit */
            line-height: 1.7;
            color: #333;
            /* Dunkelgrauer Text für gute Lesbarkeit auf hellem Overlay */
        }

        .login-description p {
            margin-top: 0;
            margin-bottom: 10px;
        }

        .login-description strong {
            color: #004d40;
            /* Dunkleres Teal für Hervorhebungen im Text */
        }

        .login-description ul {
            list-style-type: disc;
            list-style-position: outside;
            /* Aufzählungszeichen außerhalb für besseren Einzug */
            padding-left: 20px;
            margin-top: 10px;
            margin-bottom: 10px;
        }

        .login-description li {
            margin-bottom: 8px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #555;
        }

        .form-group input[type="text"],
        .form-group input[type="password"] {
            width: 100%;
            padding: 12px 15px;
            /* Mehr horizontales Padding */
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 1em;
            box-sizing: border-box;
        }

        .form-group input[type="text"]:focus,
        .form-group input[type="password"]:focus {
            border-color: #1bbaa4;
            box-shadow: 0 0 0 0.2rem rgba(27, 186, 164, 0.25);
            outline: none;
        }

        .login-btn {
            width: 100%;
            padding: 12px;
            background-color: #00796b;
            /* Ihr Button-Grün */
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 1.1em;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.2s;
            text-transform: uppercase;
            /* Button-Text in Großbuchstaben */
        }

        .login-btn:hover {
            background-color: #005a4f;
            /* Dunkleres Teal */
        }

        .login-error {
            color: #721c24;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            padding: 10px 15px;
            border-radius: 4px;
            margin-bottom: 20px;
            text-align: center;
        }
    </style>
</head>

<body class="login-page">
    <div class="login-wrapper">
        <div class="login-container">
            <h1>Willkommen!</h1>
            <h2 class="portal-title">ISO27001 Informationsportal</h2>

            <?php
            // Der Beschreibungsblock ist jetzt außerhalb der weißen Login-Formular-Box,
            // aber innerhalb des .login-container für die Breitenbeschränkung.
            // Für einen grünen Hintergrund der Seite und weißen Text im Beschreibungsblock:
            // Die Beschreibung wird jetzt innerhalb der weißen .login-container Box gerendert,
            // aber mit eigenem Styling.
            ?>
            <div class="login-description">
                <p>Dieses Portal dient als zentrale Plattform zur systematischen Erfassung und Dokumentation des aktuellen Stands unserer Informationssicherheitsmaßnahmen (Ist-Zustand). Ziel ist es, eine umfassende Grundlage für die Sicherheitsbedarfsanalyse im Rahmen unserer Vorbereitung auf die ISO 27001 Zertifizierung zu schaffen.</p>
                <p><strong>Was Sie nach dem Login finden und tun können:</strong></p>
                <ul>
                    <li><strong>Strukturierte Fragenkataloge:</strong> Navigieren Sie durch die verschiedenen Haupt- und Untermenüpunkte.</li>
                    <li><strong>Ist-Zustand dokumentieren:</strong> Beschreiben Sie den aktuellen Stand zu jeder Frage.</li>
                    <li><strong>Verbesserungspotenzial identifizieren:</strong> Halten Sie Handlungsbedarf und geplante Maßnahmen fest.</li>
                </ul>
                <p>Ihre sorgfältigen Eingaben sind ein entscheidender Beitrag für unser ISMS. Vielen Dank!</p>
            </div>

            <?php
            if (!empty($login_err)) {
                echo '<div class="login-error">' . htmlspecialchars($login_err) . '</div>';
            }
            ?>

            <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
                <div class="form-group">
                    <label for="username">Ihr Name / Kürzel</label>
                    <input type="text" name="username" id="username" value="<?php echo htmlspecialchars($username_eingabe); ?>" required>
                </div>
                <div class="form-group">
                    <label for="password">Passwort</label>
                    <input type="password" name="password" id="password" required>
                </div>
                <div class="form-group">
                    <button type="submit" class="login-btn">Anmelden</button>
                </div>
            </form>
        </div>
    </div>
</body>

</html>