#!/bin/bash

echo ** Ejecutando script de web **
date
######################################################
#### EJECUTA AQUI TODAS LAS ORDENES QUE NECESITES ####
######################################################

# 2. Permitir conexiones salientes hacia el servidor de base de datos en el puerto 3306 (MariaDB)
iptables -A OUTPUT -p tcp -d 192.168.56.102 --dport 3306 -j ACCEPT
iptables -A INPUT -p tcp -s 192.168.56.102 --sport 3306 -j ACCEPT

# 7. Permitir que el host acceda al servidor web por el puerto HTTP (80) para ver el mensaje "Éxito".
iptables -A INPUT -p tcp -s 192.168.56.1 --dport 80 -j ACCEPT
iptables -A OUTPUT -p tcp -d 192.168.56.1 --sport 80 -j ACCEPT



echo ** Fin del script de web **