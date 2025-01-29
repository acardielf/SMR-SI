#!/bin/bash

echo "Criterio 6: El servidor db acepta las conexiones entrantes de web por el puerto de MariaDB"

# Obtener las reglas de iptables en la cadena INPUT
iptables_rules=$(vagrant ssh db -c "sudo iptables -L INPUT -n --line-numbers")

# Buscar la regla que permite el acceso desde el servidor web (192.168.56.101) al puerto 3306
allow_rule=$(echo "$iptables_rules" | grep "ACCEPT" | grep "192.168.56.101" | grep "dpt:3306")

if [[ -z $allow_rule ]]; then
    echo "[✘] No se encontró una regla que permita conexiones desde web (192.168.56.101) al puerto 3306."
else
    # Verificar el orden de las reglas
    reject_rule_line=$(echo "$iptables_rules" | grep -E "DROP|REJECT" | grep "dpt:3306" | awk '{print $1}')
    allow_rule_line=$(echo "$iptables_rules" | grep "ACCEPT" | grep "192.168.56.101" | grep "dpt:3306" | awk '{print $1}')

    if [[ -z $reject_rule_line || -z $allow_rule_line ]]; then
        echo "[✘] No se pueden verificar las reglas necesarias."
    elif [[ $allow_rule_line -lt $reject_rule_line ]]; then
        echo "[✔] La regla que permite conexiones desde web está antes que la regla que rechaza conexiones al puerto 3306."
    else
        echo "[✘] La regla que permite conexiones desde web está después que la regla que rechaza conexiones al puerto 3306."
    fi
fi