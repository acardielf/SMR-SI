#!/bin/bash

######################################################
GRUPO="SOLUCION"
######################################################

echo ** Ejecutando script de VM2 de $GRUPO **
######################################################
#### EJECUTA AQUI TODAS LAS ORDENES QUE NECESITES ####
######################################################

# agregamos al principio de la lista
iptables -A INPUT -p tcp -s 192.168.56.103 -j ACCEPT

echo ** Fin del script de VM2 **