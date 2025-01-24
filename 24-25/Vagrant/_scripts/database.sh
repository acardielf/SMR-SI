#!/bin/bash

sudo apt-get update
sudo apt-get install mariadb-server -y

sudo systemctl enable mariadb
sudo systemctl start mariadb

# Configurar MariaDB
sudo mysql -e "CREATE USER 'dbuser'@'192.168.56.101' IDENTIFIED BY 'dbuser';"
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'dbuser'@'192.168.56.101' WITH GRANT OPTION;"
sudo mysql -e "FLUSH PRIVILEGES;"

# Configurar MariaDB para escuchar en todas las interfaces
sudo sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# Reiniciar MariaDB para aplicar cambios
sudo systemctl restart mariadb

echo "MariaDB instalado y configurado. Usuario: dbuser, IP permitida: 192.168.56.101"
