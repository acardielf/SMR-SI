#!/bin/bash

echo "Criterio 8: Configuración de la jail [mysqld-auth] en Fail2Ban"

# Verificar configuración de Fail2Ban en db
config=$(vagrant ssh db -c "sudo cat /etc/fail2ban/jail.local" | grep -A 100 "\[mysqld-auth\]")

# Variables para verificar cada parte de la configuración
enabled=$(echo "$config" | grep -E "enabled\s*=\s*true")
findtime=$(echo "$config" | grep -E "findtime\s*=\s*60")
maxretry=$(echo "$config" | grep -E "maxretry\s*=\s*4")
bantime=$(echo "$config" | grep -E "bantime\s*=\s*86400")
logpath=$(echo "$config" | grep "logpath\s*=\s*/var/log/mysql/error.log")

# Verificar cada parte de la configuración
criterio1=false
if [[ -z $enabled ]]; then
    echo "[✘] Fail2Ban jail [mysqld-auth] is not enabled (enabled = true not found)."
elif [[ -z $findtime ]]; then
    echo "[✘] Fail2Ban jail [mysqld-auth] has incorrect or missing findtime (expected: findtime = 60)."
elif [[ -z $maxretry ]]; then
    echo "[✘] Fail2Ban jail [mysqld-auth] has incorrect or missing maxretry (expected: maxretry = 4)."
elif [[ -z $bantime ]]; then
    echo "[✘] Fail2Ban jail [mysqld-auth] has incorrect or missing bantime (expected: bantime = 86400)."
elif [[ -z $logpath ]]; then
    echo "[✘] Fail2Ban jail [mysqld-auth] has incorrect or missing bantime (expected: logpath = /var/log/mysql/error.log)."    
else
    echo "[OK] Fail2Ban jail [mysqld-auth] is correctly configured."
    criterio1=true
fi


# Verificar si la jail está activa usando fail2ban-client status
criterio2=false
jail_status=$(vagrant ssh db -c "sudo fail2ban-client status" | grep "mysqld-auth")
if [[ $jail_status == *"mysqld-auth"* ]]; then
    echo "[OK] Fail2Ban jail [mysqld-auth] is active."
    criterio2=true
else
    echo "[✘] Fail2Ban jail [mysqld-auth] is not active."
fi

# Verificar si ambos checks son válidos
if $criterio1 && $criterio2; then
    echo "[✔] Criterio 8 cumplido: La jail [mysqld-auth] está correctamente configurada y activa."
else
    echo "[✘] Criterio 8 no cumplido: La jail [mysqld-auth] no está correctamente configurada o no está activa."
fi