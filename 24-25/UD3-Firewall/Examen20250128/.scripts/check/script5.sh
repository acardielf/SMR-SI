#!/bin/bash

echo "Criterio 5: El servidor db rechaza todas las conexiones entrantes por el puerto de MariaDB"

# Obtener las reglas de iptables en la cadena INPUT
iptables_rules=$(vagrant ssh db -c "sudo iptables -L INPUT -n --line-numbers")

# Buscar la regla que rechaza o bloquea el puerto 3306
reject_rule=$(echo "$iptables_rules" | grep -E "DROP|REJECT" | grep "dpt:3306")

if [[ -z $reject_rule ]]; then
    echo "[✘] No se encontró una regla que rechace conexiones al puerto 3306."
else
    echo "[✔] Se encontró una regla que rechaza conexiones al puerto 3306."
fi