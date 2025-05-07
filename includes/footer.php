<?php // filename: includes/footer.php
?>
        </div> </main> <footer class="app-footer">
        <div class="container">
            <p>&copy; <?php echo date("Y"); ?>Alle Rechte vorbehalten.</p>
        </div>
    </footer>

</body>
</html>
<?php
// Eventuelle Datenbankverbindung schließen
if (isset($conn) && is_object($conn) && method_exists($conn, 'close')) {
    // $conn->close(); // Wird in den Hauptdateien bereits gemacht, falls dort eingebunden.
}
?>
