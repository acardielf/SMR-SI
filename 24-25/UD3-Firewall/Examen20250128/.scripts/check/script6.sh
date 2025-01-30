#!/bin/bash

echo "Criterio 6: El servidor db acepta las conexiones entrantes de web por el puerto de MariaDB"

# Obtener las reglas de iptables en la cadena INPUT
iptables_rules=$(vagrant ssh db -c "sudo iptables -L INPUT -n --line-numbers")

# Buscar la primera regla que permite el acceso desde el servidor web (192.168.56.101) al puerto 3306
allow_rule=$(echo "$iptables_rules" | grep "ACCEPT.*192.168.56.101.*dpt:3306" | head -n 1)

if [[ -z $allow_rule ]]; then
    echo "[✘] No se encontró una regla que permita conexiones desde web (192.168.56.101) al puerto 3306."
else
    # Obtener el número de línea de la regla de permitir
    allow_rule_line=$(echo "$allow_rule" | awk '{print $1}')

    # Buscar la primera regla que rechaza conexiones al puerto 3306
    reject_rule=$(echo "$iptables_rules" | grep -E "^[0-9]+\s+(DROP|REJECT).*dpt:3306" | head -n 1)

    if [[ -z $reject_rule ]]; then
        echo "[✘] No se encontró una regla que rechace conexiones al puerto 3306."
    else
        # Obtener el número de línea de la regla de rechazar
        reject_rule_line=$(echo "$reject_rule" | awk '{print $1}')

        # Verificar el orden de las reglas
        if [[ $allow_rule_line -lt $reject_rule_line ]]; then
            echo "[✔] La regla que permite conexiones desde web está antes que la regla que rechaza conexiones al puerto 3306."
        else
            echo "[✘] La regla que permite conexiones desde web está después que la regla que rechaza conexiones al puerto 3306."
        fi
    fi
fi