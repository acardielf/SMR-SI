<?php

$servername = "192.168.56.102";
$username = "dbuser";
$password = "dbuser";

$conn = new mysqli($servername, $username, $password);

if ($conn->connect_error) {
    echo "<body style='background-color: red; color: white; text-align: center; font-size: 2em;'>
            <h1>Error. Algo falla...</h1>
          </body>";
} else {
    echo "<body style='background-color: green; color: white; text-align: center; font-size: 2em;'>
            <h1>Éxito</h1>
          </body>";
}

$conn->close();
