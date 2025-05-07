-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 07. Mai 2025 um 11:17
-- Server-Version: 10.4.32-MariaDB
-- PHP-Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `iso27001`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `antworten`
--

CREATE TABLE `antworten` (
  `id` int(11) NOT NULL,
  `frage_id` int(11) NOT NULL,
  `antwort` text NOT NULL,
  `ersteller` varchar(255) DEFAULT NULL,
  `erstellungsdatum` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `fragen`
--

CREATE TABLE `fragen` (
  `id` int(11) NOT NULL,
  `hauptmenue_id` int(11) NOT NULL,
  `untermenue_id` int(11) DEFAULT NULL,
  `frage` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `fragen`
--

INSERT INTO `fragen` (`id`, `hauptmenue_id`, `untermenue_id`, `frage`) VALUES
(1, 1, 1, 'Welche Tools werden zur Inventarisierung von Hardware-Assets (Server, Clients, Netzwerkkomponenten, Mobilgeräte etc.) eingesetzt?'),
(2, 1, 1, 'Wie aktuell und vollständig ist diese Inventarisierung? Wird sie automatisiert aktualisiert?'),
(3, 1, 1, 'Welche Tools werden zur Inventarisierung von Software-Assets (Betriebssysteme, Anwendungen, Lizenzen) genutzt?'),
(4, 1, 1, 'Wie werden nicht genehmigte Hard- oder Software-Installationen technisch erkannt?'),
(5, 1, 2, 'Werden Tools zur Schwachstellenanalyse (Vulnerability Scanner) eingesetzt? Welche? Wie oft werden Scans durchgeführt?'),
(6, 1, 2, 'Wie werden die Ergebnisse dieser Scans technisch dokumentiert und nachverfolgt?'),
(7, 1, 2, 'Gibt es eine technische Plattform zur Dokumentation und Verfolgung von Risiken und Maßnahmen?'),
(8, 1, 3, 'Welches System wird zur Versionierung und Verteilung von ISMS-Dokumenten (Richtlinien, Konzepte) genutzt?'),
(9, 1, 3, 'Wie wird der Zugriff auf diese Dokumente technisch gesteuert und protokolliert?'),
(10, 2, 4, 'Welches zentrale Verzeichnisdienstsystem wird verwendet (z.B. Microsoft Active Directory, LDAP)?'),
(11, 2, 4, 'Wie ist die Struktur des Verzeichnisdienstes aufgebaut (OUs, Gruppen)?'),
(12, 2, 4, 'Wie werden Benutzerkonten technisch angelegt, geändert und deaktiviert/gelöscht? Gibt es automatisierte Prozesse (z.B. bei Ein-/Austritt)?'),
(13, 2, 4, 'Wie werden technische/funktionale Benutzerkonten verwaltet und überwacht?'),
(14, 2, 4, 'Wie werden die Identitäten von externen Benutzern (Partner, Kunden) verwaltet, falls diese Zugriff auf Systeme benötigen?'),
(15, 2, 5, 'Welche Passwortrichtlinien sind technisch auf den Systemen durchgesetzt (Länge, Komplexität, Ablaufdatum, Historie)?'),
(16, 2, 5, 'Werden Mechanismen zur Sperrung von Konten nach fehlgeschlagenen Anmeldeversuchen eingesetzt? Wie sind diese konfiguriert?'),
(17, 2, 5, 'Wo wird Multi-Faktor-Authentifizierung (MFA) technisch eingesetzt (z.B. für Admin-Zugänge, Fernzugriff, Cloud-Dienste)? Welche MFA-Methoden werden verwendet (App, SMS, Hardware-Token)?'),
(18, 2, 5, 'Wie werden Standardpasswörter bei Systemen und Anwendungen initial geändert und verwaltet?'),
(19, 2, 6, 'Wie werden Zugriffsrechte technisch zugewiesen (z.B. rollenbasiert über Gruppen im Verzeichnisdienst)?'),
(20, 2, 6, 'Wie wird das Prinzip der minimalen Rechtevergabe (Need-to-know) technisch umgesetzt und überprüft?'),
(21, 2, 6, 'Wie werden administrative Berechtigungen technisch verwaltet und deren Nutzung protokolliert? Gibt es dedizierte Admin-Konten?'),
(22, 2, 6, 'Wie werden Zugriffsrechte auf Dateifreigaben, Datenbanken und Anwendungen technisch administriert und dokumentiert?'),
(23, 2, 6, 'Finden regelmäßige technische Überprüfungen der vergebenen Berechtigungen statt (Rezertifizierung)? Werden Tools dafür eingesetzt?'),
(24, 3, 7, 'Welche Festplattenverschlüsselung wird für Laptops und ggf. Desktops eingesetzt (z.B. BitLocker, LUKS)? Wie wird diese zentral verwaltet (Key Management)?'),
(25, 3, 7, 'Werden Datenbanken oder einzelne Spalten/Tabellen verschlüsselt? Mit welchen Algorithmen und wie sieht das Schlüsselmanagement aus?'),
(26, 3, 7, 'Wie werden Backup-Daten auf Medien verschlüsselt? Welche Verfahren und Schlüssel werden genutzt?'),
(27, 3, 8, 'Welche Protokolle werden zur Verschlüsselung der Kommunikation im internen Netz und nach außen eingesetzt (z.B. TLS-Versionen für HTTPS, SSH, VPNs)?'),
(28, 3, 8, 'Wie wird die Konfiguration von TLS auf Webservern und anderen Diensten gehärtet (Cipher Suites, Zertifikate)?'),
(29, 3, 8, 'Werden E-Mails verschlüsselt (z.B. S/MIME, PGP)? Gibt es eine zentrale Infrastruktur dafür?'),
(30, 3, 9, 'Wie und wo werden kryptographische Schlüssel sicher generiert, gespeichert, verteilt, rotiert und vernichtet?'),
(31, 3, 9, 'Werden Hardware Security Modules (HSMs) eingesetzt?'),
(32, 3, 9, 'Wie ist der Zugriff auf Schlüsselmaterial technisch geschützt?'),
(33, 3, 10, 'Wie werden interne und externe digitale Zertifikate (z.B. für TLS, WLAN-Authentifizierung) verwaltet? Gibt es eine interne PKI?'),
(34, 3, 10, 'Wie wird die Gültigkeit von Zertifikaten überwacht und deren Erneuerung sichergestellt?'),
(35, 3, 11, 'Welche Backup-Software wird eingesetzt? Ist sie aktuell?'),
(36, 3, 11, 'Auf welche Zielmedien wird gesichert (Band, Disk, Cloud)? Wie ist deren Kapazität und Performance?'),
(37, 3, 11, 'Wie ist die Backup-Infrastruktur (Backup-Server, Speicher) selbst abgesichert?'),
(38, 3, 12, 'Welche Systeme und Daten (Server, VMs, Datenbanken, Anwendungen, Konfigurationen von Netzwerkgeräten) werden gesichert?'),
(39, 3, 12, 'Wie sind die Backup-Zeitpläne technisch konfiguriert (Voll-, Inkremental-, Differenzial-Backups)?'),
(40, 3, 12, 'Wie werden die Recovery Point Objectives (RPO) technisch eingehalten?'),
(41, 3, 13, 'Wie wird die erfolgreiche Durchführung der Backups technisch überwacht und protokolliert?'),
(42, 3, 13, 'Gibt es automatische Benachrichtigungen bei fehlgeschlagenen Backups?'),
(43, 3, 14, 'Wie oft und in welchem Umfang werden Wiederherstellungstests technisch durchgeführt?'),
(44, 3, 14, 'Werden verschiedene Szenarien getestet (Einzeldateien, komplette Systeme, Datenbanken)?'),
(45, 3, 14, 'Wie werden die Ergebnisse der Tests technisch dokumentiert?'),
(46, 3, 14, 'Wie werden die Recovery Time Objectives (RTO) technisch überprüft?'),
(47, 3, 15, 'Wie lange werden Backups technisch aufbewahrt (online, offline)?'),
(48, 3, 15, 'Werden Backup-Kopien an einem externen, sicheren Ort gelagert? Wie ist dieser Ort technisch gesichert?'),
(49, 4, 16, 'Welche Systeme und Tools werden zur Identifizierung und Verteilung von Sicherheitspatches für Betriebssysteme und Anwendungen eingesetzt (z.B. WSUS, SCCM, Ansible, etc.)?'),
(50, 4, 16, 'Wie ist der Prozess zur Bewertung und Priorisierung von Patches technisch unterstützt?'),
(51, 4, 16, 'Wie werden Patches vor dem Rollout technisch getestet (Testumgebung)?'),
(52, 4, 16, 'Wie wird der Installationsstatus von Patches auf allen Systemen technisch überwacht und dokumentiert?'),
(53, 4, 16, 'Gibt es definierte Zeitfenster für das Einspielen von Patches? Wie werden Notfallpatches gehandhabt?'),
(54, 4, 17, 'Welches System (z.B. Ticketsystem, CMDB) wird zur Dokumentation, Genehmigung und Nachverfolgung von Änderungen an IT-Systemen und -Anwendungen verwendet?'),
(55, 4, 17, 'Wie werden die technischen Auswirkungen von Änderungen vorab bewertet?'),
(56, 4, 17, 'Gibt es einen technischen Rollback-Plan für fehlgeschlagene Änderungen?'),
(57, 4, 17, 'Wie werden Konfigurationsänderungen an Systemen versioniert und dokumentiert?'),
(58, 4, 18, 'Welche Antimalware-Software (Virenscanner, EDR) ist auf allen Clients und Servern installiert und aktiv?'),
(59, 4, 18, 'Wie wird sichergestellt, dass die Signaturen/Pattern-Dateien und die Software selbst aktuell sind (zentrale Verwaltungskonsole)?'),
(60, 4, 18, 'Wie sind die Scan-Einstellungen konfiguriert (Echtzeit-Scan, geplante Scans)?'),
(61, 4, 18, 'Wie werden Malware-Funde zentral gemeldet, protokolliert und behandelt?'),
(62, 4, 19, 'Werden Malware-Filter auf E-Mail-Gateways eingesetzt? Welche?'),
(63, 4, 19, 'Werden Malware-Filter auf Web-Gateways/Proxies eingesetzt? Welche?'),
(64, 4, 19, 'Gibt es netzwerkbasierte Intrusion Detection/Prevention Systeme (IDS/IPS) mit Funktionen zur Malware-Erkennung?'),
(65, 4, 20, 'Werden Technologien zur Verhaltensanalyse oder Sandboxing zur Erkennung unbekannter Malware eingesetzt?'),
(66, 4, 20, 'Gibt es Maßnahmen zur Härtung von Systemen, um die Ausführung von Schadcode zu erschweren (z.B. Application Whitelisting, Makrosicherheit)?'),
(67, 4, 21, 'Wie wird technisch verhindert oder kontrolliert, dass Schadsoftware über USB-Sticks etc. eingeschleust wird (z.B. Sperrung von USB-Ports, Scanpflicht)?'),
(68, 4, 22, 'Welche Systeme und Anwendungen generieren sicherheitsrelevante Protokolldaten (Betriebssysteme, Firewalls, Webserver, Datenbanken, Authentifizierungsserver, Anwendungen etc.)?'),
(69, 4, 22, 'Welche Ereignisse werden genau protokolliert (Logins, fehlgeschlagene Logins, administrative Aktionen, Systemfehler, Zugriffsversuche, Konfigurationsänderungen etc.)?'),
(70, 4, 23, 'Werden Protokolldaten zentral gesammelt (z.B. auf einem SIEM-System oder Log-Server)?'),
(71, 4, 23, 'Wie lange werden Protokolldaten aufbewahrt? Ist dies konform mit gesetzlichen/regulatorischen Anforderungen?'),
(72, 4, 23, 'Wie ist die Integrität und Vertraulichkeit der Protokolldaten technisch sichergestellt (Schutz vor Manipulation, Zugriffskontrolle)?'),
(73, 4, 23, 'Ist die Zeit auf allen Systemen synchronisiert (NTP), um korrelierte Analysen zu ermöglichen?'),
(74, 4, 24, 'Wie und wie oft werden Protokolldaten ausgewertet (manuell, automatisiert durch SIEM-Regeln)?'),
(75, 4, 24, 'Gibt es definierte Use Cases und Alarmierungen für sicherheitskritische Ereignisse, die in den Logs erkannt werden?'),
(76, 4, 24, 'Wer ist für die Auswertung zuständig und wie wird auf Alarme reagiert?'),
(77, 5, 25, 'Sind netzwerkbasierte (NIDS/NIPS) und/oder hostbasierte (HIDS/HIPS) Systeme im Einsatz? Welche Produkte?'),
(78, 5, 25, 'Wie werden diese Systeme konfiguriert und mit Signaturen/Regeln versorgt?'),
(79, 5, 25, 'Wie werden Alarme von IDS/IPS-Systemen empfangen, analysiert und weiterverfolgt?'),
(80, 5, 26, 'Ist ein SIEM-System im Einsatz? Welche Logquellen sind angebunden?'),
(81, 5, 26, 'Welche Korrelationsregeln sind im SIEM definiert, um komplexe Angriffe oder Anomalien zu erkennen?'),
(82, 5, 26, 'Wie werden SIEM-Alarme bearbeitet und eskaliert?'),
(83, 5, 27, 'Wie wird der Status und die Funktionsfähigkeit von Sicherheitskomponenten (Firewalls, Virenscanner, IDS/IPS) selbst überwacht?'),
(84, 5, 27, 'Gibt es Alarme bei Ausfall oder Fehlkonfiguration dieser Systeme?'),
(85, 5, 28, 'Sind Tools für die Analyse von Sicherheitsvorfällen vorhanden (z.B. für Logfile-Analyse, Netzwerk-Traffic-Analyse, Malware-Analyse in einer Sandbox)?'),
(86, 5, 28, 'Gibt es definierte Kommunikationskanäle (auch alternative, falls primäre Systeme betroffen sind) für das Incident Response Team?'),
(87, 5, 28, 'Sind technische Möglichkeiten zur Isolierung von betroffenen Systemen (z.B. VLAN-Änderung, Port-Sperrung) vorbereitet?'),
(88, 5, 29, 'Wie wird technisch sichergestellt, dass Beweismittel (Logfiles, Speicherabbilder, Festplattenimages) korrekt gesichert werden?'),
(89, 5, 29, 'Welche technischen Schritte werden zur Eindämmung, Beseitigung und Wiederherstellung nach verschiedenen Arten von Vorfällen (Malware, DoS, unberechtigter Zugriff) durchgeführt?'),
(90, 5, 30, 'Gibt es detaillierte technische Wiederanlaufpläne für kritische IT-Systeme und -Dienste?'),
(91, 5, 30, 'Sind die notwendigen technischen Ressourcen für einen Wiederanlauf (z.B. Backup-Systeme, Ersatzhardware, Software-Installationsmedien, Lizenzen) verfügbar und zugänglich?'),
(92, 5, 30, 'Sind Ausweichstandorte (Rechenzentrum, Arbeitsplätze) technisch ausgestattet und testbereit?'),
(93, 5, 31, 'Wie werden Notfallübungen technisch durchgeführt (z.B. Rücksicherung von Systemen auf Testumgebungen, Umschaltung auf redundante Systeme)?'),
(94, 5, 31, 'Werden die in den Notfallplänen definierten technischen Schritte auf ihre Durchführbarkeit und Zeitdauer getestet?'),
(95, 6, 32, 'Welche technischen Zutrittskontrollsysteme sind für den Serverraum/das RZ im Einsatz (z.B. Transponderkarten, PIN-Codes, biometrische Systeme)?'),
(96, 6, 32, 'Wie werden die Zutrittsberechtigungen technisch verwaltet und regelmäßig überprüft?'),
(97, 6, 32, 'Werden alle Zutrittsversuche (erfolgreich und fehlgeschlagen) technisch protokolliert? Wo und wie lange?'),
(98, 6, 32, 'Gibt es eine Videoüberwachung (CCTV) für den Eingangsbereich oder innerhalb des Serverraums? Wie werden die Aufzeichnungen gespeichert und geschützt?'),
(99, 6, 32, 'Sind Türen und Fenster (falls vorhanden) technisch gegen unbefugtes Öffnen gesichert (z.B. Alarmkontakte)?'),
(100, 6, 33, 'Welche Systeme zur Überwachung von Temperatur und Luftfeuchtigkeit sind installiert?'),
(101, 6, 33, 'Wie sind die Schwellwerte für Alarme konfiguriert? An wen werden Alarme technisch gemeldet?'),
(102, 6, 33, 'Welche Klimatisierungssysteme (Anzahl, Redundanz, Typ) sind im Einsatz? Wie werden diese gewartet und überwacht?'),
(103, 6, 33, 'Gibt es Systeme zur Erkennung von Wassereinbruch (Leckagesensoren)?'),
(104, 6, 34, 'Ist eine unterbrechungsfreie Stromversorgung (USV) vorhanden? Welcher Typ, welche Kapazität (kVA) und welche Überbrückungszeit bei Volllast?'),
(105, 6, 34, 'Welche Systeme sind an die USV angeschlossen? Sind die Lasten pro USV-Phase ausbalanciert?'),
(106, 6, 34, 'Wie wird der Status der USV (Batteriezustand, Last, Restlaufzeit) technisch überwacht? Gibt es Selbsttests? Wann war der letzte Batterietausch?'),
(107, 6, 34, 'Existiert eine Netzersatzanlage (NEA / Generator)? Wie ist diese dimensioniert? Wann wurde der letzte Testlauf durchgeführt? Wie wird der Kraftstoffvorrat überwacht?'),
(108, 6, 34, 'Gibt es getrennte Stromkreise für kritische Systeme? Wie ist die Stromverteilung im Rack (PDUs) abgesichert und überwacht?'),
(109, 6, 35, 'Welche Brandfrüherkennungssysteme sind installiert (z.B. optische Rauchmelder, thermische Melder, Rauchansaugsysteme - RAS)?'),
(110, 6, 35, 'Welches Brandlöschsystem ist im Einsatz (z.B. Gaslöschanlage – welches Gas?, Sauerstoffreduktionsanlage, Handfeuerlöscher – welcher Typ und wo platziert)?'),
(111, 6, 35, 'Wann wurden die Brandmelde- und Löschanlagen zuletzt technisch geprüft und gewartet?'),
(112, 6, 35, 'Sind Abschottungen für Kabeldurchführungen vorhanden und korrekt ausgeführt?'),
(113, 6, 36, 'Sind Daten- und Stromkabel getrennt und geordnet verlegt (z.B. in Kabeltrassen, Doppelboden)?'),
(114, 6, 36, 'Ist die Verkabelung (Patchpanel, Kabel) sauber dokumentiert und beschriftet?'),
(115, 6, 36, 'Werden nur feuerhemmende Kabeltypen verwendet?'),
(116, 6, 37, 'Gibt es aktuelle und detaillierte Verkabelungspläne (Grundrisse mit Kabelwegen, Verteilerstandorte, Anschlussdosen)?'),
(117, 6, 37, 'Ist die Dokumentation der Patchverbindungen in den Verteilern aktuell (Portbelegung)?'),
(118, 6, 38, 'Wie sind die Hauptverteiler (Gebäudeverteiler, Etagenverteiler) physisch gesichert (abschließbare Räume/Schränke)?'),
(119, 6, 38, 'Sind Kabelwege in öffentlichen Bereichen oder Risikobereichen besonders geschützt (z.B. Kabelkanäle, Unterputzverlegung)?'),
(120, 6, 38, 'Werden Abstände zu potenziellen Störquellen (Starkstromleitungen, Motoren, Leuchtstoffröhren) bei der Verlegung von Kupferkabeln eingehalten, um elektromagnetische Interferenzen (EMI) zu minimieren?'),
(121, 6, 38, 'Werden Glasfaserkabel vor mechanischer Beschädigung (Biegeradien, Zugbelastung) geschützt?'),
(122, 6, 39, 'Wurden die Installationsarbeiten von qualifiziertem Personal durchgeführt? Gibt es Messprotokolle für die installierten Strecken (Kupfer und LWL)?'),
(123, 6, 39, 'Wie wird mit nicht mehr genutzten Kabelsegmenten umgegangen (Rückbau, Dokumentation)?'),
(124, 7, 40, 'Ist das Netzwerk in logische Zonen segmentiert (z.B. DMZ, Servernetz, Clientnetz, Produktionsnetz, WLAN-Gästenetz)?'),
(125, 7, 40, 'Welche Technologien werden zur Segmentierung eingesetzt (VLANs, separate Switches, Firewalls)?'),
(126, 7, 40, 'Wie wird der Datenverkehr zwischen den Segmenten technisch kontrolliert und gefiltert (Firewall-Regeln)?'),
(127, 7, 41, 'Sind kritische Netzwerkkomponenten (Core-Switches, Router, Firewalls) redundant ausgelegt (z.B. gestackte Switches, Cluster)?'),
(128, 7, 41, 'Gibt es redundante Netzwerkpfade (z.B. Spanning Tree Protocol Konfiguration, Link Aggregation)?'),
(129, 7, 41, 'Existieren redundante Internetanbindungen? Wie ist das Failover technisch realisiert (z.B. Router-Protokolle, SD-WAN)?'),
(130, 7, 42, 'Wie ist das IP-Adressmanagement organisiert? Gibt es eine Dokumentation der vergebenen Adressbereiche und statischen Adressen?'),
(131, 7, 42, 'Welche DHCP-Server sind im Einsatz? Wie sind deren Bereiche und Optionen konfiguriert? Sind sie redundant?'),
(132, 7, 42, 'Welche DNS-Server (intern/extern) werden verwendet? Wie sind diese konfiguriert und abgesichert (z.B. gegen DNS-Spoofing, DoS)?'),
(133, 7, 43, 'Welche Tools werden zur Überwachung der Netzwerkperformance und -verfügbarkeit eingesetzt (z.B. SNMP-Monitoring, NetFlow/sFlow Analyzer)?'),
(134, 7, 43, 'Wie werden Ausfälle oder Engpässe im Netzwerk technisch erkannt und gemeldet?'),
(135, 7, 44, 'Welche Firewall-Produkte (Hersteller, Modell, Softwareversion) sind im Einsatz (Perimeter, interne Segmentierung)? Sind sie aktuell und supportet?'),
(136, 7, 44, 'Sind die Firewalls redundant ausgelegt (z.B. HA-Cluster)? Wie ist das Failover konfiguriert und getestet?'),
(137, 7, 45, 'Wie ist das Firewall-Regelwerk strukturiert und dokumentiert?'),
(138, 7, 45, 'Gilt das Prinzip \"deny by default\" (alles verbieten, was nicht explizit erlaubt ist)?'),
(139, 7, 45, 'Werden Regeln regelmäßig überprüft und nicht mehr benötigte Regeln entfernt?'),
(140, 7, 45, 'Wie werden Any-Any-Regeln vermieden oder streng kontrolliert?'),
(141, 7, 45, 'Werden Quell- und Ziel-IP-Adressen, Ports und Protokolle so spezifisch wie möglich definiert?'),
(142, 7, 45, 'Gibt es einen dokumentierten Prozess für die Beantragung und Freigabe neuer Firewall-Regeln?'),
(143, 7, 46, 'Werden Funktionen wie Intrusion Prevention (IPS), Application Control, URL-Filterung oder Antivirus auf der Firewall genutzt? Wie sind diese konfiguriert?'),
(144, 7, 46, 'Wird der Datenverkehr für bestimmte Dienste per Deep Packet Inspection (DPI) analysiert?'),
(145, 7, 47, 'Welche Ereignisse werden von der Firewall protokolliert (erlaubter/geblockter Traffic, administrative Änderungen, Systemereignisse)?'),
(146, 7, 47, 'Werden die Firewall-Logs zentral gesammelt und ausgewertet (z.B. SIEM)?'),
(147, 7, 47, 'Wie wird die Auslastung (CPU, Speicher, Netzwerkdurchsatz) der Firewall überwacht?'),
(148, 7, 48, 'Welche Sicherheitsstandards werden für die verschiedenen WLANs (intern, Gäste) eingesetzt (z.B. WPA2/WPA3-Enterprise, WPA2/WPA3-Personal)?'),
(149, 7, 48, 'Bei WPA2/WPA3-Enterprise: Welcher Authentifizierungsserver (z.B. RADIUS) und welche EAP-Methode (z.B. EAP-TLS, PEAP) werden verwendet?'),
(150, 7, 48, 'Wie stark sind die Pre-Shared Keys (PSK) für WPA2/WPA3-Personal, falls verwendet? Wie werden sie verwaltet und geändert?'),
(151, 7, 49, 'Sind interne und Gäste-WLANs logisch voneinander getrennt (z.B. eigene VLANs, Firewall-Regeln)?'),
(152, 7, 49, 'Wird die SSID des internen WLANs ausgestrahlt oder verborgen? (Hinweis: Verbergen ist keine starke Sicherheitsmaßnahme).'),
(153, 7, 49, 'Ist die Sendeleistung der Access Points angemessen konfiguriert, um die Abdeckung auf den benötigten Bereich zu beschränken?'),
(154, 7, 50, 'Wie ist der administrative Zugriff auf die Access Points gesichert (starke Passwörter, HTTPS, SSH)?'),
(155, 7, 50, 'Sind die Firmware der Access Points und des WLAN-Controllers aktuell?'),
(156, 7, 50, 'Werden unautorisierte (\"rogue\") Access Points im Netzwerk technisch erkannt?'),
(157, 8, 51, 'Sind die Betriebssysteme gehärtet (unnötige Dienste deaktiviert, nicht benötigte Software deinstalliert, Sicherheitsrichtlinien konfiguriert)?'),
(158, 8, 51, 'Werden Security Baselines oder Härtungsleitfäden (z.B. CIS Benchmarks) verwendet und deren Einhaltung überprüft?'),
(159, 8, 51, 'Wie ist der administrative Zugriff auf die Server gesichert (dedizierte Admin-Konten, MFA, sichere Protokolle wie SSH/RDP über VPN)?'),
(160, 8, 52, 'Wie wird sichergestellt, dass Betriebssystem- und Anwendungspatches zeitnah installiert werden? (siehe auch OPS.1.1.3)'),
(161, 8, 53, 'Ist Antimalware-Software auf allen Servern installiert und aktuell? (siehe auch OPS.1.1.4)'),
(162, 8, 54, 'Welche System- und Sicherheitsereignisse werden auf den Servern protokolliert? Werden sie zentral gesammelt? (siehe auch OPS.1.1.5)'),
(163, 8, 55, 'Werden Änderungen an Serverkonfigurationen dokumentiert und versioniert (z.B. durch Infrastructure-as-Code Tools, CMDB)?'),
(164, 8, 56, 'Wenn Server dezentral stehen: Wie sind sie physisch gesichert?'),
(165, 8, 57, 'Werden Clients über eine zentrale Lösung (z.B. Gruppenrichtlinien, MDM/UEM) einheitlich konfiguriert und gehärtet?'),
(166, 8, 57, 'Sind lokale Administratorrechte für Standardbenutzer eingeschränkt?'),
(167, 8, 57, 'Ist Festplattenverschlüsselung auf allen Clients (insbesondere Laptops) aktiviert und zentral verwaltet?'),
(168, 8, 57, 'Sind Bildschirmsperren mit Passwortschutz nach kurzer Inaktivitätszeit technisch erzwungen?'),
(169, 8, 58, 'Wie wird die Installation von Software auf Clients gesteuert (erlaubte Anwendungen, Softwareverteilung)?'),
(170, 8, 58, 'Wie wird nicht genehmigte Software erkannt und entfernt?'),
(171, 8, 59, 'Ist Antimalware-Software installiert, aktuell und zentral verwaltet?'),
(172, 8, 59, 'Ist eine Host-basierte Firewall auf den Clients aktiv und konfiguriert?'),
(173, 8, 59, 'Wie wird der Einsatz von Wechseldatenträgern (USB-Sticks) technisch kontrolliert (z.B. Sperrung, Verschlüsselungspflicht, Scanpflicht)?'),
(174, 8, 59, 'Patchmanagement: Wie bei Servern, oft zentral gesteuert.'),
(175, 8, 60, 'Gibt es technische Maßnahmen zum Auffinden oder Sperren/Löschen von verlorenen oder gestohlenen Laptops (Remote Wipe)?'),
(176, 8, 60, 'Wie ist der Fernzugriff auf das Unternehmensnetzwerk (VPN) für Laptops technisch abgesichert (Authentifizierung, Verschlüsselung)?'),
(177, 8, 61, 'Ist die Festplattenverschlüsselung zwingend?'),
(178, 8, 61, 'Gibt es Richtlinien und technische Kontrollen für die Nutzung von öffentlichen WLANs?'),
(179, 9, 62, 'Werden sicherheitsrelevante Einstellungen für Office-Anwendungen und Webbrowser zentral vorgegeben und technisch durchgesetzt (z.B. Makrosicherheit, Skriptausführung, Umgang mit aktiven Inhalten, Konfiguration von Vertrauensstellungen)?'),
(180, 9, 62, 'Werden Browser-Erweiterungen zentral verwaltet oder eingeschränkt?'),
(181, 9, 63, 'Wie wird sichergestellt, dass Office-Pakete und Webbrowser (inkl. Plug-Ins) zeitnah mit Sicherheitspatches versorgt werden?'),
(182, 9, 64, 'Wie ist der E-Mail-Server selbst gehärtet und abgesichert (Betriebssystem, Mailserver-Software)?'),
(183, 9, 64, 'Welche Maßnahmen zum Schutz vor Spam und Phishing sind auf dem Server implementiert (Spamfilter, Antivirus, SPF, DKIM, DMARC Konfiguration)?'),
(184, 9, 64, 'Wie ist der Zugriff auf administrative Schnittstellen des Mailservers geschützt?'),
(185, 9, 65, 'Wie sind E-Mail-Clients sicher konfiguriert (z.B. keine automatische Anzeige externer Inhalte, Warnung vor verdächtigen Links)?'),
(186, 9, 65, 'Wird Transportverschlüsselung (TLS) für den Mailabruf (IMAP/POP3) und -versand (SMTP) erzwungen?'),
(187, 9, 66, 'Gibt es eine E-Mail-Archivierung? Wie ist diese technisch realisiert und der Zugriff darauf geschützt?'),
(188, 9, 67, 'Wie erfolgt die Benutzerauthentifizierung an der Anwendung (eigene Benutzerverwaltung, Anbindung an zentralen Verzeichnisdienst)?'),
(189, 9, 67, 'Gibt es ein rollenbasiertes Berechtigungskonzept innerhalb der Anwendung? Wie wird dies technisch umgesetzt?'),
(190, 9, 68, 'Werden Secure Coding Richtlinien im Entwicklungsprozess beachtet?'),
(191, 9, 68, 'Werden Sicherheitstests (z.B. Penetrationstests, Code-Reviews) vor der Produktivsetzung neuer Anwendungsversionen durchgeführt?'),
(192, 9, 69, 'Protokolliert die Anwendung sicherheitsrelevante Ereignisse (Logins, fehlgeschlagene Logins, kritische Aktionen, Fehler)? Werden diese Logs zentralisiert?'),
(193, 9, 70, 'Wie sind Schnittstellen (APIs) zu anderen Systemen abgesichert (Authentifizierung, Autorisierung, Verschlüsselung)?'),
(282, 2, 109, 'Welche Informationssicherheitsaspekte (z.B. Unterzeichnung von Vertraulichkeitserklärungen, Akzeptanz von Nutzungsrichtlinien) sind fester Bestandteil des Onboarding-Prozesses neuer Mitarbeiter?'),
(283, 2, 109, 'Sind Sicherheitsverantwortlichkeiten und Verpflichtungen zur Einhaltung von Sicherheitsrichtlinien in Arbeitsverträgen oder Stellenbeschreibungen klar definiert?'),
(284, 2, 110, 'Welche regelmäßigen Schulungs- und Sensibilisierungsmaßnahmen zur Informationssicherheit (z.B. Phishing-Simulationen, Passwortsicherheit, Umgang mit Daten, Meldung von Vorfällen) gibt es für alle Mitarbeiter?'),
(285, 2, 110, 'Wie wird die Teilnahme und der Lernerfolg dieser Maßnahmen dokumentiert und bewertet?'),
(286, 2, 110, 'Gibt es spezifische Schulungen für Mitarbeiter mit besonderen Sicherheitsverantwortlichkeiten (z.B. Admins, Entwickler, Management)?'),
(287, 2, 111, 'Wie werden sensible Mitarbeiterdaten (z.B. Gehaltsinformationen, Gesundheitsdaten, Leistungsbeurteilungen) gemäß Datenschutzanforderungen geschützt?'),
(288, 2, 111, 'Wer hat Zugriff auf Mitarbeiterdaten und wie ist dieser Zugriff technisch und organisatorisch geregelt?'),
(289, 2, 112, 'Existiert ein standardisierter Offboarding-Prozess, der sicherstellt, dass alle Zugriffsrechte (physisch und logisch) von ausscheidenden Mitarbeitern zeitnah entzogen werden?'),
(290, 2, 112, 'Wie wird die Rückgabe von Unternehmenseigentum (Laptops, Mobiltelefone, Schlüssel, Dokumente) sichergestellt und dokumentiert?'),
(291, 6, 32, 'Welche physischen Zugangskontrollmechanismen (z.B. Schlüssel, Transponderkarten, PIN-Codes, Biometrie, Empfangspersonal) werden für den Zugang zu Firmengebäuden und einzelnen Bürobereichen eingesetzt?'),
(292, 6, 32, 'Wie wird der Zutritt von Besuchern, externen Dienstleistern und Lieferanten geregelt, überwacht und protokolliert?'),
(293, 6, 32, 'Werden Ein- und Ausgänge (auch Notausgänge) überwacht und sind sie gegen unbefugten Zutritt gesichert?'),
(294, 6, 32, 'Wie sind Serverräume und andere Bereiche mit kritischer IT-Infrastruktur physisch gesichert (z.B. separate Zugangskontrollen, Videoüberwachung, Einbruchmeldeanlagen)?'),
(295, 6, 113, 'Gibt es eine \"Clean Desk\" und \"Clear Screen\" Richtlinie und wie wird deren Einhaltung gefördert und überprüft?'),
(296, 6, 113, 'Wie werden vertrauliche Dokumente und Datenträger am Arbeitsplatz sicher aufbewahrt, wenn sie nicht in Gebrauch sind?'),
(297, 6, 113, 'Sind unbeaufsichtigte Arbeitsplätze (PCs, Laptops) durch passwortgeschützte Bildschirmschoner gesichert?'),
(298, 6, 33, 'Welche Vorkehrungen sind getroffen, um IT-Systeme und Informationswerte vor Schäden durch Wasser, Stromausfall oder anderen Naturereignissen (außer Feuer) zu schützen?'),
(299, 6, 35, 'Sind Notfallpläne für den Katastrophenfall (z.B. Feuer, Überflutung) vorhanden, die auch die Informationssicherheit berücksichtigen?'),
(300, 6, 114, 'Gibt es Prozesse zur Kontrolle des Ein- und Ausgangs von IT-Geräten, Datenträgern und wichtigen Dokumenten aus dem Unternehmen?'),
(301, 6, 114, 'Wie wird sichergestellt, dass Geräte, die das Unternehmen verlassen (z.B. zur Reparatur, Entsorgung), keine sensiblen Daten mehr enthalten?'),
(333, 21, 143, 'Wie ist der Prozess für die Anlage, Änderung und Deaktivierung von Benutzerkonten im abas ERP-System definiert und wer ist dafür verantwortlich?'),
(334, 21, 143, 'Existiert ein dokumentiertes Rollen- und Berechtigungskonzept für abas, das auf dem Prinzip der minimalen Rechtevergabe (Least Privilege) basiert?'),
(335, 21, 143, 'Wie oft und von wem werden die vergebenen Berechtigungen im abas System überprüft (Rezertifizierung)?'),
(336, 21, 143, 'Welche Maßnahmen sind implementiert, um Standardpasswörter im abas System bei der Ersteinrichtung oder für neue Benutzer zu ändern?'),
(337, 21, 144, 'Wie wird der direkte Zugriff auf die abas-Datenbank (Backend) kontrolliert und auf ein Minimum beschränkt?'),
(338, 21, 144, 'Welche Sicherheitsmaßnahmen sind auf dem Datenbankserver des abas Systems implementiert (z.B. Härtung, Patchmanagement, Netzwerksegmentierung)?'),
(339, 21, 144, 'Werden Datenbank-Backups des abas Systems regelmäßig erstellt, sicher aufbewahrt und deren Wiederherstellbarkeit getestet?'),
(340, 21, 145, 'Welche Systeme (intern/extern) sind über Schnittstellen an das abas ERP-System angebunden und wie ist der Datenfluss dokumentiert?'),
(341, 21, 145, 'Wie werden die Authentifizierung und Autorisierung für den Zugriff über diese Schnittstellen gehandhabt (z.B. API-Keys, Service-Konten)?'),
(342, 21, 145, 'Wird der Datenverkehr über diese Schnittstellen verschlüsselt und werden die Schnittstellen auf Sicherheitslücken überwacht?'),
(343, 21, 146, 'Welche Benutzeraktivitäten und Systemereignisse werden im abas ERP-System standardmäßig protokolliert?'),
(344, 21, 146, 'Gibt es einen Prozess zur regelmäßigen Überprüfung dieser Protokolle auf verdächtige Aktivitäten oder Sicherheitsvorfälle?'),
(345, 21, 146, 'Wie lange werden die Protokolldaten des abas Systems aufbewahrt und wie ist deren Integrität sichergestellt?'),
(346, 21, 147, 'Existieren Richtlinien für sicheres Customizing und Eigenentwicklungen im abas ERP-System (z.B. Vermeidung von Hardcoding von Credentials, Input-Validierung)?'),
(347, 21, 147, 'Wie werden Änderungen (Customizing, neue Module, Reports) im abas System vor der Produktivsetzung in einer separaten Testumgebung auf Sicherheitsaspekte geprüft?'),
(348, 21, 147, 'Werden Code-Reviews für abas-spezifische Entwicklungen durchgeführt, die auch Sicherheitsaspekte abdecken?'),
(349, 22, 148, 'Existiert ein dokumentiertes Schema zur Klassifizierung von Unternehmensdaten (z.B. öffentlich, intern, vertraulich, streng vertraulich) und wer ist für die Klassifizierung verantwortlich?'),
(350, 22, 148, 'Wie werden Mitarbeiter im Umgang mit Daten unterschiedlicher Klassifizierungsstufen geschult?'),
(351, 22, 148, 'Sind die Schutzmaßnahmen (z.B. Zugriffskontrollen, Verschlüsselung) an die jeweilige Datenklassifizierung gekoppelt?'),
(352, 22, 149, 'Existiert ein aktuelles Verzeichnis von Verarbeitungstätigkeiten (VVT) für personenbezogene Kundendaten gemäß Art. 30 DSGVO?'),
(353, 22, 149, 'Wie wird die Rechtsgrundlage für die Verarbeitung personenbezogener Kundendaten für jeden Verarbeitungszweck dokumentiert und überprüft?'),
(354, 22, 149, 'Wie werden Kunden über die Verarbeitung ihrer Daten informiert (Datenschutzerklärung) und wie werden Einwilligungen (falls erforderlich) eingeholt und verwaltet?'),
(355, 22, 149, 'Gibt es Prozesse zur Bearbeitung von Betroffenenanfragen (Auskunft, Berichtigung, Löschung, Einschränkung der Verarbeitung, Datenübertragbarkeit, Widerspruch)?'),
(356, 22, 150, 'Welche technischen und organisatorischen Maßnahmen (TOMs) sind implementiert, um die Sicherheit bei der Speicherung und dem Zugriff auf sensible Daten (insbesondere Kunden- und Mitarbeiterdaten) zu gewährleisten?'),
(357, 22, 150, 'Werden sensible Daten während der Übertragung (z.B. über öffentliche Netze, zwischen Systemen) standardmäßig verschlüsselt (z.B. TLS, SFTP)?'),
(358, 22, 150, 'Werden sensible Daten auf Speichermedien (Festplatten, Backups, mobile Datenträger) verschlüsselt (Data at Rest)? Welche Verfahren werden eingesetzt?'),
(359, 22, 151, 'Gibt es Richtlinien und technische Maßnahmen zur Datenminimierung, um sicherzustellen, dass nur die für den jeweiligen Zweck erforderlichen personenbezogenen Daten verarbeitet werden?'),
(360, 22, 151, 'Sind Aufbewahrungsfristen für alle Kategorien personenbezogener Daten festgelegt und dokumentiert, unter Berücksichtigung gesetzlicher und geschäftlicher Anforderungen?'),
(361, 22, 151, 'Existiert ein dokumentiertes Löschkonzept, das beschreibt, wie und wann personenbezogene Daten nach Ablauf der Aufbewahrungsfrist sicher gelöscht oder anonymisiert werden?'),
(362, 22, 152, 'Welche Richtlinien gibt es für die Nutzung und den Schutz von mobilen Datenträgern (z.B. USB-Sticks, externe Festplatten, Laptops)? Ist Verschlüsselung vorgeschrieben?'),
(363, 22, 152, 'Wie werden Datenträger (Festplatten, SSDs, Bänder, USB-Sticks etc.), die sensible Daten enthalten, vor der Wiederverwendung, Reparatur oder endgültigen Entsorgung sicher gelöscht oder physisch zerstört?'),
(364, 22, 152, 'Wird die sichere Entsorgung von Datenträgern dokumentiert?'),
(365, 9, 134, 'Wie werden Sicherheitsanforderungen (funktionale und nicht-funktionale) systematisch in der Anforderungsanalyse und im Design neuer Software oder Features berücksichtigt (z.B. durch Threat Modeling, Missbrauchsfälle)?'),
(366, 9, 134, 'Existieren dokumentierte \"Secure by Design\"-Prinzipien oder -Richtlinien und wie wird deren Einhaltung im Designprozess überprüft und dokumentiert?'),
(367, 9, 134, 'Wie wird sichergestellt, dass Datenschutzanforderungen (Privacy by Design, Privacy by Default gemäß DSGVO) bereits in der Designphase von Anwendungen berücksichtigt werden?'),
(368, 9, 135, 'Welches Versionskontrollsystem (z.B. Git) wird für welche Codebase verwendet und wie sind die Branching-Strategien (z.B. GitFlow) und Commit-Richtlinien definiert, um Code-Integrität und Nachvollziehbarkeit zu gewährleisten?'),
(369, 9, 135, 'Wie wird sichergestellt, dass sensible Informationen (Passwörter, API-Keys, Zertifikate) nicht direkt im Quellcode oder in Konfigurationsdateien im Repository gespeichert werden, und welche alternativen Management-Methoden werden verwendet (z.B. Vault-Systeme)?'),
(370, 9, 135, 'Gibt es Richtlinien und technische Kontrollen zur Sicherung von Entwickler-Workstations und deren Zugriff auf Code-Repositories (z.B. Schutz vor Malware, unbefugtem Zugriff, Einsatz von SSH-Keys)?'),
(371, 9, 136, 'Welche Arten von Sicherheitstests (z.B. SAST, DAST, manuelle Penetrationstests, Fuzzing) werden systematisch während des Entwicklungszyklus und vor Releases durchgeführt und mit welchen Tools/Methoden?'),
(372, 9, 136, 'Wie werden die Ergebnisse von Sicherheitstests (insbesondere gefundene Schwachstellen) dokumentiert, nach Schweregrad priorisiert, deren Behebung nachverfolgt und verifiziert?'),
(373, 9, 136, 'Werden Testdaten verwendet, die anonymisiert, pseudonymisiert oder synthetisch sind, um den Schutz von Produktivdaten in Testumgebungen sicherzustellen und DSGVO-Anforderungen zu erfüllen?'),
(374, 9, 137, 'Welche automatisierten Deployment-Prozesse (CI/CD-Pipelines) sind im Einsatz und wie werden Sicherheitsprüfungen (z.B. automatisierte Scans auf Schwachstellen in Dependencies, Konfigurationsprüfungen, manuelle Freigaben) als Teil dieser Pipelines integriert und erzwungen?'),
(375, 9, 137, 'Wie wird die Integrität und Authentizität von Software-Artefakten während des Build- und Deployment-Prozesses sichergestellt (z.B. durch digitale Signaturen, Hash-Überprüfungen, sichere Artefakt-Repositories)?'),
(376, 9, 137, 'Existieren dokumentierte und regelmäßig getestete Rollback-Verfahren für fehlgeschlagene oder problematische Deployments, um eine schnelle Wiederherstellung des vorherigen stabilen Zustands zu ermöglichen?'),
(377, 9, 138, 'Gibt es unternehmensweite oder teamspezifische Coding Standards und Secure Coding Richtlinien (z.B. basierend auf OWASP Secure Coding Practices) und wie werden diese kommuniziert, durchgesetzt und deren Einhaltung überprüft?'),
(378, 9, 138, 'Wie ist der Code-Review-Prozess formalisiert (z.B. obligatorische Pull Requests, Checklisten für Reviewer)? Werden Sicherheitsaspekte explizit und nachvollziehbar bei Code Reviews geprüft?'),
(379, 9, 138, 'Werden Entwickler regelmäßig in sicheren Programmierpraktiken und im Umgang mit gängigen Schwachstellenkategorien (z.B. OWASP Top 10, CWE Top 25) geschult, um präventiv sicheren Code zu schreiben?'),
(380, 9, 139, 'Wie werden lokale Entwicklungsumgebungen auf den Rechnern der Programmierer standardisiert, gesichert (z.B. Festplattenverschlüsselung, Malware-Schutz, eingeschränkte Rechte, regelmäßige Updates) und deren Konfiguration verwaltet?'),
(381, 9, 139, 'Wie sind die verschiedenen Umgebungen (Entwicklung, Test, Staging, Produktion) voneinander logisch und physisch getrennt, insbesondere hinsichtlich Netzwerkzugriff, Datenflüssen und Benutzerberechtigungen, um unbefugte Zugriffe oder Datenlecks zu verhindern?'),
(382, 9, 139, 'Werden Werkzeuge für Infrastructure as Code (IaC) (z.B. Terraform, Ansible) verwendet, um Entwicklungsinfrastrukturen konsistent zu provisionieren, und wie werden die IaC-Skripte selbst versioniert, auf Sicherheitsaspekte geprüft und sicher verwaltet?'),
(383, 9, 140, 'Welche Richtlinien und technischen Verfahren gibt es für die Erstellung, Verwendung und den Schutz von Testdaten? Werden Produktivdaten für Tests verwendet, und wenn ja, wie werden sie effektiv anonymisiert oder pseudonymisiert, um Datenschutzanforderungen zu erfüllen?'),
(384, 9, 140, 'Wie und wo werden sensible Konfigurationsdaten, Secrets (z.B. Datenbank-Credentials, API-Schlüssel) und Zertifikate für Entwicklungs- und Testumgebungen sicher gespeichert, verwaltet und der Zugriff darauf kontrolliert (z.B. dedizierte Secrets-Management-Tools, verschlüsselte Umgebungsvariablen)?'),
(385, 9, 140, 'Welche sicherheitsrelevanten Ereignisse werden von den in Entwicklung befindlichen Anwendungen protokolliert und wie wird sichergestellt, dass in Entwicklungs-Logs keine ungeschützten sensiblen Daten (z.B. Passwörter, personenbezogene Daten) erscheinen?'),
(386, 9, 141, 'Wie wird der Zugriff auf Quellcode-Repositories (z.B. Git-Server, GitHub, GitLab) verwaltet? Werden rollenbasierte Berechtigungen (RBAC) nach dem Prinzip der minimalen Rechtevergabe angewendet und regelmäßig überprüft?'),
(387, 9, 141, 'Wie wird der Zugriff auf zentrale Entwicklungstools wie CI/CD-Systeme (z.B. Jenkins, GitLab CI), Issue Tracker (z.B. Jira) und Artefakt-Repositories (z.B. Nexus, Artifactory) gesteuert, abgesichert und protokolliert?'),
(388, 9, 141, 'Gibt es einen Prozess zur regelmäßigen Überprüfung (Rezertifizierung) der Zugriffsberechtigungen von Entwicklern und Service-Konten auf Entwicklungstools und -systeme, um verwaiste oder überprivilegierte Konten zu identifizieren?'),
(389, 9, 142, 'Gibt es einen formalisierten Prozess zur Bewertung, Freigabe und Überwachung von Open-Source-Bibliotheken und Drittanbieter-Komponenten hinsichtlich ihrer Sicherheit (z.B. bekannte Schwachstellen via CVEs, Lizenzkonformität, Wartungsstatus, Herkunft) bevor sie in Projekten eingesetzt werden?'),
(390, 9, 142, 'Wie werden Software-Abhängigkeiten (Dependencies) verwaltet und regelmäßig automatisiert auf bekannte Schwachstellen gescannt (z.B. mit Tools wie OWASP Dependency-Check, Snyk, npm audit), und wie ist der Prozess zur Behebung oder Minderung gefundener Schwachstellen in diesen Komponenten definiert?'),
(391, 9, 142, 'Welche Cloud-Dienste (IaaS, PaaS, SaaS) werden für Entwicklungs-, Test- oder Build-Prozesse genutzt und wie wird deren sichere Konfiguration (gemäß Shared Responsibility Model) und der Zugriff darauf (z.B. API-Keys, Service Principals) gewährleistet und dokumentiert?'),
(415, 1, 153, 'Wie wurden interne und externe Themen, die für den Zweck der Organisation relevant sind und ihre Fähigkeit beeinflussen, die beabsichtigten Ergebnisse ihres ISMS zu erreichen, bestimmt und dokumentiert?'),
(416, 1, 153, 'Welche interessierten Parteien (Stakeholder) sind für das ISMS relevant und welche Anforderungen dieser Parteien wurden ermittelt?'),
(417, 1, 153, 'Wie ist der Geltungsbereich (Scope) des ISMS klar definiert und dokumentiert (z.B. welche Organisationseinheiten, Standorte, Prozesse, Technologien sind eingeschlossen)?'),
(418, 1, 154, 'Wie demonstriert die oberste Leitung ihre Führung und Verpflichtung in Bezug auf das ISMS (z.B. durch Sicherstellung der Ressourcen, Kommunikation der Bedeutung, Förderung der kontinuierlichen Verbesserung)?'),
(419, 1, 154, 'Existiert eine aktuelle, von der Leitung genehmigte Informationssicherheitsleitlinie, die die Ziele und die Ausrichtung der Informationssicherheit festlegt und allen relevanten Parteien kommuniziert wird?'),
(420, 1, 154, 'Sind Rollen, Verantwortlichkeiten und Befugnisse für informationssicherheitsrelevante Aufgaben klar definiert, zugewiesen und kommuniziert (z.B. Informationssicherheitsbeauftragter - ISB)?'),
(421, 1, 155, 'Sind messbare Informationssicherheitsziele auf relevanten Funktionen und Ebenen festgelegt, die mit der Informationssicherheitsleitlinie im Einklang stehen?'),
(422, 1, 155, 'Wie wird die Planung zur Erreichung der Informationssicherheitsziele durchgeführt (Was wird getan? Welche Ressourcen? Wer ist verantwortlich? Wann abgeschlossen? Wie werden Ergebnisse bewertet?)?'),
(423, 1, 155, 'Wie werden Änderungen am ISMS geplant und kontrolliert durchgeführt, um negative Auswirkungen auf die Informationssicherheit zu minimieren?'),
(424, 1, 156, 'Wie stellt die Organisation sicher, dass die für die Einrichtung, Umsetzung, Aufrechterhaltung und fortlaufende Verbesserung des ISMS erforderlichen Ressourcen (Personal, Finanzen, Technologie) bereitgestellt werden?'),
(425, 1, 156, 'Wie wird die notwendige Kompetenz von Personen, die informationssicherheitsrelevante Tätigkeiten ausführen, sichergestellt (z.B. durch Ausbildung, Schulung, Erfahrung)?'),
(426, 1, 156, 'Wie wird das Bewusstsein (Awareness) der Mitarbeiter für die Informationssicherheitsleitlinie, ihren Beitrag zur Wirksamkeit des ISMS und die Folgen der Nichterfüllung von Anforderungen gefördert?'),
(427, 1, 156, 'Welche internen und externen Kommunikationsprozesse bezüglich des ISMS sind etabliert (Was, wann, mit wem, wie wird kommuniziert)?'),
(428, 1, 157, 'Was wird im Rahmen des ISMS überwacht und gemessen, um die Leistung der Informationssicherheit und die Wirksamkeit des ISMS zu bewerten?'),
(429, 1, 157, 'Welche Methoden zur Überwachung, Messung, Analyse und Bewertung werden angewendet, um gültige Ergebnisse sicherzustellen?'),
(430, 1, 157, 'Wann müssen die Überwachung und Messung durchgeführt und die Ergebnisse analysiert und bewertet werden?'),
(431, 1, 158, 'Wird ein internes Auditprogramm geplant und durchgeführt, um zu überprüfen, ob das ISMS den Anforderungen der Organisation und der ISO 27001 entspricht und wirksam umgesetzt wird?'),
(432, 1, 158, 'Wie wird die Auswahl der Auditoren und die Durchführung der Audits sichergestellt, um Objektivität und Unparteilichkeit des Auditprozesses zu gewährleisten?'),
(433, 1, 158, 'Führt die oberste Leitung in geplanten Abständen Management Reviews des ISMS durch, um dessen fortdauernde Eignung, Angemessenheit und Wirksamkeit sicherzustellen?'),
(434, 1, 158, 'Welche Inputs werden für das Management Review berücksichtigt und welche Ergebnisse und Entscheidungen werden dokumentiert?'),
(435, 1, 159, 'Wie geht die Organisation mit Nichtkonformitäten (Abweichungen von ISMS-Anforderungen) um, einschließlich der Ergreifung von Korrekturmaßnahmen zur Beseitigung der Ursachen?'),
(436, 1, 159, 'Existiert ein Prozess zur fortlaufenden Verbesserung der Eignung, Angemessenheit und Wirksamkeit des ISMS, basierend auf den Ergebnissen der Leistungsbewertung, Audits und Management Reviews?'),
(437, 2, 160, 'Existieren dokumentierte Richtlinien für mobiles Arbeiten und Fernzugriff, die Sicherheitsanforderungen für Mitarbeiter (insbesondere Außendienst) klar definieren?'),
(438, 2, 160, 'Wie werden Mitarbeiter bezüglich der Risiken und sicheren Verhaltensweisen beim mobilen Arbeiten und der Nutzung von Fernzugriffen (z.B. Umgang mit vertraulichen Daten außerhalb des Büros, Nutzung öffentlicher WLANs) geschult und sensibilisiert?'),
(439, 2, 160, 'Gibt es klare Anweisungen und Prozesse für die Meldung von Sicherheitsvorfällen, die im Kontext des mobilen Arbeitens oder Fernzugriffs auftreten?'),
(440, 7, 161, 'Welche VPN-Technologie (z.B. IPsec, SSL-VPN) wird für den Fernzugriff eingesetzt und wie wird deren sichere Konfiguration (Protokolle, Verschlüsselungsalgorithmen, Authentifizierungsmethoden) gewährleistet?'),
(441, 7, 161, 'Wie wird die Authentifizierung für VPN-Zugänge gehandhabt? Wird Multi-Faktor-Authentifizierung (MFA) für VPN-Zugänge eingesetzt?'),
(442, 7, 161, 'Wie wird der Netzwerkverkehr über VPN-Verbindungen überwacht und werden Zugriffsversuche auf interne Ressourcen protokolliert?'),
(443, 7, 161, 'Gibt es Mechanismen zur Überprüfung des Sicherheitsstatus von Endgeräten (Endpoint Compliance Check), bevor eine VPN-Verbindung zugelassen wird?'),
(444, 8, 162, 'Wird eine Mobile Device Management (MDM) oder Unified Endpoint Management (UEM) Lösung zur Verwaltung und Absicherung von firmeneigenen mobilen Geräten (Smartphones, Tablets, Laptops) eingesetzt?'),
(445, 8, 162, 'Welche Sicherheitsrichtlinien werden über MDM/UEM auf mobilen Geräten durchgesetzt (z.B. Passwortkomplexität, Bildschirmsperre, Geräteverschlüsselung, Jailbreak/Root-Erkennung, Remote Wipe Funktionen)?'),
(446, 8, 162, 'Existieren Richtlinien und technische Kontrollen für die Nutzung privater Geräte für geschäftliche Zwecke (BYOD - Bring Your Own Device), insbesondere hinsichtlich des Zugriffs auf Unternehmensdaten und -anwendungen?'),
(447, 8, 162, 'Wie wird der Umgang mit verlorenen oder gestohlenen mobilen Geräten gehandhabt (Meldeprozess, technische Maßnahmen wie Fernsperrung oder -löschung von Daten)?'),
(448, 23, 163, 'Welche externen Cloud-Dienste (z.B. IONOS für Hosting/Domains, Microsoft 365, Google Workspace, AWS, Azure) werden für welche kritischen Geschäftsprozesse oder zur Speicherung/Verarbeitung sensibler Daten eingesetzt?'),
(449, 23, 163, 'Wie wird die Verantwortungsteilung (Shared Responsibility Model) für Sicherheitsmaßnahmen zwischen dem Unternehmen und dem Cloud-Anbieter (z.B. IONOS) verstanden, dokumentiert und umgesetzt?'),
(450, 23, 163, 'Welche vertraglichen Vereinbarungen (SLAs, AVVs gemäß DSGVO) bestehen mit Cloud-Anbietern, die Informationssicherheits- und Datenschutzanforderungen abdecken?'),
(451, 23, 163, 'Wie wird die sichere Konfiguration der genutzten Cloud-Dienste gewährleistet (z.B. Identitäts- und Zugriffsmanagement, Netzwerksicherheitseinstellungen, Datenverschlüsselung in der Cloud, Konfiguration von Backup- und Wiederherstellungsoptionen)?'),
(452, 23, 163, 'Wie wird der administrative Zugriff auf die Management-Konsolen der Cloud-Dienste (z.B. IONOS Kundenkonto) abgesichert (MFA, starke Passwörter, minimale Rechte) und überwacht?'),
(453, 23, 163, 'Werden die Sicherheitszertifizierungen und Auditberichte (z.B. ISO 27001, SOC 2) der Cloud-Anbieter regelmäßig geprüft und bewertet, um deren Sicherheitsniveau einzuschätzen?'),
(454, 23, 164, 'Existiert ein formalisierter Prozess zur Identifizierung, Bewertung und Behandlung von Informationssicherheitsrisiken, die von externen Lieferanten und Dienstleistern ausgehen (Third-Party Risk Management)?'),
(455, 23, 164, 'Werden Informationssicherheitsanforderungen und Vertraulichkeitsvereinbarungen (NDAs) standardmäßig in Verträge mit allen relevanten Lieferanten (Software, Hardware, Dienstleistungen) aufgenommen?'),
(456, 23, 164, 'Wie wird die Einhaltung der vereinbarten Sicherheitsmaßnahmen durch die Lieferanten während der Vertragslaufzeit überwacht, überprüft und auditiert (z.B. durch Fragebögen, Zertifikatsprüfungen, Audits vor Ort)?'),
(457, 23, 164, 'Gibt es definierte Prozesse für den Umgang mit Sicherheitsvorfällen, die Lieferanten betreffen, aber Auswirkungen auf die Informationssicherheit des eigenen Unternehmens haben könnten (Supply Chain Incidents)?');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `hauptmenues`
--

CREATE TABLE `hauptmenues` (
  `id` int(11) NOT NULL,
  `titel` varchar(255) NOT NULL,
  `beschreibung` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `hauptmenues`
--

INSERT INTO `hauptmenues` (`id`, `titel`, `beschreibung`) VALUES
(1, '1. ISMS: Informationssicherheitsmanagementsystem', 'Rahmenwerk und Grundlagen des Informationssicherheitsmanagementsystems.'),
(2, '2. ORP: Organisation und Personal', 'Rollen, Verantwortlichkeiten und personelle Sicherheitsaspekte.'),
(3, '3. CON: Konzepte und Vorgehensweisen', 'Strategien, Richtlinien und methodische Ansätze zur Informationssicherheit.'),
(4, '4. OPS: Betrieb', 'Sicherer Betrieb von IT-Systemen und Management von Sicherheitsmaßnahmen.'),
(5, '5. DER: Detektion und Reaktion', 'Erkennung von und Reaktion auf Informationssicherheitsvorfälle.'),
(6, '6. INF: Infrastruktur', 'Physische Sicherheit von Standorten und Schutz der IT-Infrastruktur.'),
(7, '7. NET: Netze und Kommunikation', 'Sicherheit von Netzwerkdiensten und Schutz der Datenübertragung.'),
(8, '8. SYS: IT-Systeme', 'Absicherung von Servern, Clients und anderen IT-Systemkomponenten.'),
(9, '9. ANW: Anwendungs- & Entwicklungs-Sicherheit', 'Sicherheitsaspekte im gesamten Lebenszyklus von Anwendungen, inklusive Entwicklung, Standardsoftware und Betrieb.'),
(21, '10. ERP: Sicherheit abas System', 'Konfiguration, Zugriffskontrolle und sicherer Betrieb des abas ERP-Systems.'),
(22, '11. DAT: Datenschutz & Datensicherheit', 'Schutz sensibler Daten, insbesondere Kunden- und Geschäftsdaten, gemäß gesetzlicher Vorgaben.'),
(23, '12. EXT: Externe Dienste & Lieferanten', 'Management von Informationssicherheitsrisiken bei der Nutzung von Cloud-Diensten und in Beziehungen zu externen Lieferanten.');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `untermenues`
--

CREATE TABLE `untermenues` (
  `id` int(11) NOT NULL,
  `hauptmenue_id` int(11) NOT NULL,
  `titel` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `untermenues`
--

INSERT INTO `untermenues` (`id`, `hauptmenue_id`, `titel`) VALUES
(1, 1, 'Asset Management (Technische Aspekte)'),
(2, 1, 'Risikomanagement (Technische Aspekte)'),
(3, 1, 'Dokumentenmanagement für das ISMS'),
(4, 2, 'Identitätsmanagement'),
(5, 2, 'Authentisierungsmechanismen'),
(6, 2, 'Berechtigungsmanagement'),
(7, 3, 'Datenverschlüsselung (Data-at-Rest)'),
(8, 3, 'Datenverschlüsselung (Data-in-Transit)'),
(9, 3, 'Schlüsselmanagement'),
(10, 3, 'Zertifikatsmanagement'),
(11, 3, 'Backup-Software und -Hardware'),
(12, 3, 'Backup-Umfang und -Zeitplan'),
(13, 3, 'Backup-Durchführung und -Überwachung'),
(14, 3, 'Wiederherstellungstests'),
(15, 3, 'Aufbewahrung und Auslagerung'),
(16, 4, 'Patchmanagement'),
(17, 4, 'Änderungsmanagement (Change Management)'),
(18, 4, 'Endpunktschutz (Clients, Server)'),
(19, 4, 'Netzwerkbasierter Schutz'),
(20, 4, 'Verhaltensanalyse und erweiterter Schutz'),
(21, 4, 'Umgang mit Wechseldatenträgern'),
(22, 4, 'Protokollquellen'),
(23, 4, 'Protokollspeicherung und -management'),
(24, 4, 'Protokollauswertung'),
(25, 5, 'Intrusion Detection/Prevention Systeme (IDS/IPS)'),
(26, 5, 'Security Information and Event Management (SIEM)'),
(27, 5, 'Überwachung von Sicherheitskomponenten'),
(28, 5, 'Technische Vorbereitung'),
(29, 5, 'Technische Reaktion'),
(30, 5, 'Technische Notfallpläne'),
(31, 5, 'Technische Tests'),
(32, 6, 'Physischer Zutrittsschutz'),
(33, 6, 'Umgebungsbedingungen'),
(34, 6, 'Stromversorgung'),
(35, 6, 'Brandschutz'),
(36, 6, 'Verkabelung im RZ/Serverraum'),
(37, 6, 'Planung und Dokumentation'),
(38, 6, 'Physische Sicherheit der Verkabelung'),
(39, 6, 'Installation und Wartung'),
(40, 7, 'Netzwerksegmentierung'),
(41, 7, 'Redundanz'),
(42, 7, 'Adressierung und Namensauflösung'),
(43, 7, 'Netzwerkmanagement und -überwachung'),
(44, 7, 'Firewall-Hardware/Software'),
(45, 7, 'Regelwerk (Policies)'),
(46, 7, 'Zusatzfunktionen'),
(47, 7, 'Logging und Monitoring'),
(48, 7, 'Authentifizierung und Verschlüsselung'),
(49, 7, 'Netzwerkkonfiguration'),
(50, 7, 'Access Point Sicherheit'),
(51, 8, 'Betriebssystem-Härtung'),
(52, 8, 'Patchmanagement'),
(53, 8, 'Schutz vor Schadsoftware'),
(54, 8, 'Protokollierung'),
(55, 8, 'Konfigurationsmanagement'),
(56, 8, 'Physische Sicherheit (falls nicht im RZ)'),
(57, 8, 'Betriebssystem-Härtung und Konfiguration'),
(58, 8, 'Softwaremanagement'),
(59, 8, 'Schutzmaßnahmen'),
(60, 8, 'Diebstahlschutz und Fernzugriff'),
(61, 8, 'Datensicherheit unterwegs'),
(62, 9, 'Konfigurationssicherheit'),
(63, 9, 'Update-Management'),
(64, 9, 'Server-Sicherheit'),
(65, 9, 'Client-Sicherheit'),
(66, 9, 'Archivierung und Zugriff'),
(67, 9, 'Authentifizierung und Autorisierung in Anwendungen'),
(68, 9, 'Sichere Entwicklung (falls Eigenentwicklungen)'),
(69, 9, 'Protokollierung in Anwendungen'),
(70, 9, 'Schnittstellen'),
(109, 2, 'Onboarding & Vertragsgestaltung'),
(110, 2, 'Schulung & Sensibilisierung (Awareness)'),
(111, 2, 'Umgang mit Mitarbeiterdaten'),
(112, 2, 'Offboarding & Wissensübergabe'),
(113, 6, 'Arbeitsplatzsicherheit (Clean Desk/Screen)'),
(114, 6, 'Material- & Geräte-Handling (Ein-/Ausgang)'),
(134, 9, 'Anforderungsmanagement & Design'),
(135, 9, 'Implementierung & Versionskontrolle'),
(136, 9, 'Testing (Sicherheit, Performance)'),
(137, 9, 'Deployment & Release Management'),
(138, 9, 'Code-Qualität & Sichere Programmierung'),
(139, 9, 'Infrastruktur & Entwicklungsumgebungen'),
(140, 9, 'Datenmanagement in der Entwicklung'),
(141, 9, 'Zugriffskontrolle (Entwicklungstools & Repos)'),
(142, 9, 'Drittanbieter-Komponenten & Services'),
(143, 21, 'Benutzer- & Berechtigungsmanagement (abas)'),
(144, 21, 'Datenbanksicherheit (abas Backend)'),
(145, 21, 'Schnittstellen & Integrationen (abas)'),
(146, 21, 'Protokollierung & Überwachung (abas)'),
(147, 21, 'Customizing & Entwicklung (abas)'),
(148, 22, 'Klassifizierung von Daten'),
(149, 22, 'Erfassung & Verarbeitung von Kundendaten (DSGVO)'),
(150, 22, 'Speicherung, Zugriff & Verschlüsselung'),
(151, 22, 'Datenminimierung, Aufbewahrung & Löschkonzepte'),
(152, 22, 'Datenträgermanagement & -entsorgung'),
(153, 1, 'Kontext der Organisation & Geltungsbereich'),
(154, 1, 'Führung & Verpflichtung der Leitung'),
(155, 1, 'Informationssicherheitsziele & Planung'),
(156, 1, 'Unterstützung (Ressourcen, Kompetenz, Kommunikation)'),
(157, 1, 'Leistungsbewertung & Überwachung'),
(158, 1, 'Interne Audits & Management Review'),
(159, 1, 'Kontinuierliche Verbesserung'),
(160, 2, 'Mobiles Arbeiten & Fernzugriffsrichtlinien'),
(161, 7, 'Fernzugriff & VPN-Sicherheit (Technik)'),
(162, 8, 'Sicherheit mobiler Endgeräte (MDM, BYOD)'),
(163, 23, 'Cloud-Sicherheit (IaaS, PaaS, SaaS - z.B. IONOS)'),
(164, 23, 'Lieferanten-Risikomanagement & Verträge');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `antworten`
--
ALTER TABLE `antworten`
  ADD PRIMARY KEY (`id`),
  ADD KEY `frage_id` (`frage_id`);

--
-- Indizes für die Tabelle `fragen`
--
ALTER TABLE `fragen`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hauptmenue_id` (`hauptmenue_id`),
  ADD KEY `untermenue_id` (`untermenue_id`);

--
-- Indizes für die Tabelle `hauptmenues`
--
ALTER TABLE `hauptmenues`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `untermenues`
--
ALTER TABLE `untermenues`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hauptmenue_id` (`hauptmenue_id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `antworten`
--
ALTER TABLE `antworten`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT für Tabelle `fragen`
--
ALTER TABLE `fragen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=458;

--
-- AUTO_INCREMENT für Tabelle `hauptmenues`
--
ALTER TABLE `hauptmenues`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT für Tabelle `untermenues`
--
ALTER TABLE `untermenues`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=165;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `antworten`
--
ALTER TABLE `antworten`
  ADD CONSTRAINT `antworten_ibfk_1` FOREIGN KEY (`frage_id`) REFERENCES `fragen` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `fragen`
--
ALTER TABLE `fragen`
  ADD CONSTRAINT `fragen_ibfk_1` FOREIGN KEY (`hauptmenue_id`) REFERENCES `hauptmenues` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fragen_ibfk_2` FOREIGN KEY (`untermenue_id`) REFERENCES `untermenues` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `untermenues`
--
ALTER TABLE `untermenues`
  ADD CONSTRAINT `untermenues_ibfk_1` FOREIGN KEY (`hauptmenue_id`) REFERENCES `hauptmenues` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
