#!/bin/bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                                                                       #
#                                                                                                                       #
# ███████╗███████╗████████╗███████╗    ███████╗██╗ ██████╗██╗  ██╗███████╗██████╗  ██████╗                              #
# ██╔════╝██╔════╝╚══██╔══╝██╔════╝    ██╔════╝██║██╔════╝██║  ██║██╔════╝██╔══██╗██╔═══██╗                             #
# █████╗  ███████╗   ██║   █████╗      █████╗  ██║██║     ███████║█████╗  ██████╔╝██║   ██║                             #
# ██╔══╝  ╚════██║   ██║   ██╔══╝      ██╔══╝  ██║██║     ██╔══██║██╔══╝  ██╔══██╗██║   ██║                             #
# ███████╗███████║   ██║   ███████╗    ██║     ██║╚██████╗██║  ██║███████╗██║  ██║╚██████╔╝                             #
# ╚══════╝╚══════╝   ╚═╝   ╚══════╝    ╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝ ╚═════╝                              #
#                                                                                                                       #
# ███████╗███████╗    ██╗   ██╗███████╗                                                                                 #
# ██╔════╝██╔════╝    ██║   ██║██╔════╝                                                                                 #
# ███████╗█████╗      ██║   ██║█████╗                                                                                   #
# ╚════██║██╔══╝      ╚██╗ ██╔╝██╔══╝                                                                                   #
# ███████║███████╗     ╚████╔╝ ███████╗                                                                                 #
# ╚══════╝╚══════╝      ╚═══╝  ╚══════╝                                                                                 #
#                                                                                                                       #
# ██████╗ ███████╗██████╗  ██████╗     ███╗   ██╗ ██████╗     ███████╗███████╗    ████████╗ ██████╗  ██████╗ █████╗     #
# ██╔══██╗██╔════╝██╔══██╗██╔═══██╗    ████╗  ██║██╔═══██╗    ██╔════╝██╔════╝    ╚══██╔══╝██╔═══██╗██╔════╝██╔══██╗    #
# ██████╔╝█████╗  ██████╔╝██║   ██║    ██╔██╗ ██║██║   ██║    ███████╗█████╗         ██║   ██║   ██║██║     ███████║    #
# ██╔═══╝ ██╔══╝  ██╔══██╗██║   ██║    ██║╚██╗██║██║   ██║    ╚════██║██╔══╝         ██║   ██║   ██║██║     ██╔══██║    #
# ██║     ███████╗██║  ██║╚██████╔╝    ██║ ╚████║╚██████╔╝    ███████║███████╗       ██║   ╚██████╔╝╚██████╗██║  ██║    #
# ╚═╝     ╚══════╝╚═╝  ╚═╝ ╚═════╝     ╚═╝  ╚═══╝ ╚═════╝     ╚══════╝╚══════╝       ╚═╝    ╚═════╝  ╚═════╝╚═╝  ╚═╝    #
#                                                                                                                       #
#                                                                                                                       #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #












sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo iptables -t nat -F
sudo iptables -t mangle -F
sudo iptables -F
sudo iptables -X 



sudo apt-get update
sudo apt-get install mariadb-server -y

sudo systemctl enable mariadb
sudo systemctl start mariadb

sudo mysql -e "CREATE USER IF NOT EXISTS 'dbuser'@'192.168.56.101' IDENTIFIED BY 'dbuser';"
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'dbuser'@'192.168.56.101' WITH GRANT OPTION;"
sudo mysql -e "FLUSH PRIVILEGES;"


sudo sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

sudo systemctl restart mariadb
echo "MariaDB instalado y configurado. Usuario: dbuser, IP permitida: 192.168.56.101"



sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

sudo iptables -P OUTPUT DROP

# Permitir conexiones locales
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT

# Permitir conexiones DNS para resolver nombres de dominio y conexiones HTTP y HTTPS para actualizaciones
sudo iptables -I INPUT -p udp --sport 53 -j ACCEPT
sudo iptables -I INPUT -p tcp --sport 53 -j ACCEPT
sudo iptables -I OUTPUT -p udp --dport 53 -j ACCEPT
sudo iptables -I OUTPUT -p tcp --dport 53 -j ACCEPT
sudo iptables -I OUTPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -I OUTPUT -p tcp --dport 443 -j ACCEPT