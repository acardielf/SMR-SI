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


# clave ssh
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N "" -q

# agregamos las tareas al crontab
crontab -u vagrant -l > lista_cron

echo "0 * * * * /vagrant/backup_scripts/backup_db.sh" >> lista_cron
echo "0 3 * * 0 /vagrant/backup_scripts/backup_full.sh" >> lista_cron
echo "0 4 1 * * /vagrant/backup_scripts/backup_monthly.sh" >> lista_cron
echo "0 5 1 1 * /vagrant/backup_scripts/backup_yearly.sh" >> lista_cron
echo "0 6 * * * /vagrant/backup_scripts/backup_sync.sh" >> lista_cron

crontab -u vagrant lista_cron
rm lista_cron

echo ** Fin del script de VM1 **