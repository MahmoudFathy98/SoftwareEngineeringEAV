<?php

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "software";

// connect to the database
$db = mysqli_connect($servername, $username, $password, $dbname);
mysqli_query($db, "set character_set_server='utf8'");
    mysqli_query($db, "set names 'utf8'");

$GLOBALS["con"] = $db;

?>
