#!/bin/bash

echo ** Ejecutando script de base de datos **
date
######################################################
#### EJECUTA AQUI TODAS LAS ORDENES QUE NECESITES ####
######################################################


# 3. Rechazar todas las conexiones entrantes por defecto
sudo iptables -P INPUT DROP

# 4. Aceptar todas las conexiones salientes por defecto
sudo iptables -P OUTPUT ACCEPT

# 6. Aceptar conexiones entrantes desde el servidor web (192.168.56.101) al puerto 3306
# Esta regla tiene que ir antes de que se define en 5
sudo iptables -A INPUT -p tcp -s 192.168.56.101 --dport 3306 -j ACCEPT

# 5. Rechazar todas las conexiones entrantes al puerto 3306 (MariaDB) de cualquier origen
sudo iptables -A INPUT -p tcp --dport 3306 -j REJECT

# 8. Configurar Fail2Ban para bloquear ataques de fuerza bruta al puerto MariaDB
sudo apt-get install fail2ban -y
sudo rm -rf /etc/fail2ban/jail.local
sudo cp -rf /vagrant/jail.local /etc/fail2ban/jail.local
sudo systemctl restart fail2ban


echo ** Fin del script de base de datos **

