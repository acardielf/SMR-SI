#!/bin/bash

# Actualizar repositorios e instalar Apache y PHP
sudo apt-get update
sudo apt-get install -y apache2 php php-mysqli

# Habilitar el inicio automático de Apache
sudo systemctl enable apache2
sudo systemctl start apache2

# Crear el archivo index.php
cat << 'EOF' | sudo tee /var/www/html/index.php
<?php
$servername = "192.168.56.102";
$username = "dbuser";
$password = "dbuser";

// Intentar conexión con la base de datos
$conn = new mysqli($servername, $username, $password);

// Generar la salida en base al estado de la conexión
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
?>
EOF


# Cambiar permisos para que Apache pueda leer el archivo
sudo chown www-data:www-data /var/www/html/index.php
sudo chmod 644 /var/www/html/index.php
sudo rm /var/www/html/index.html

# Asegurar que Apache está configurado para el puerto 80
sudo sed -i 's/^Listen .*/Listen 80/' /etc/apache2/ports.conf

# Reiniciar Apache para aplicar cambios
sudo systemctl restart apache2

echo "Apache y PHP configurados. Visita esta máquina en el navegador para probar la conexión."
