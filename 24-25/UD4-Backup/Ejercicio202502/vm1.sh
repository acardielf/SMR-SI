#!/bin/bash

######################################################
GRUPO="SOLUCION"
######################################################

echo ** Ejecutando script de VM1 de $GRUPO **
######################################################
#### EJECUTA AQUI TODAS LAS ORDENES QUE NECESITES ####
######################################################


# agregamos al principio de la lista
iptables -A OUTPUT -p tcp -d 192.168.56.104 -j ACCEPT

crontab -l > lista_cron

echo "0 * * * * /vagrant/backup_scripts/backup_db.sh" >> lista_cron
echo "0 3 * * 0 /vagrant/backup_scripts/backup_full.sh" >> lista_cron
echo "0 4 1 * * /vagrant/backup_scripts/backup_monthly.sh" >> lista_cron
echo "0 5 1 1 * /vagrant/backup_scripts/backup_yearly.sh" >> lista_cron

crontab lista_cron
rm lista_cron

echo ** Fin del script de VM1 **