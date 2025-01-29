#!/bin/bash

echo "Criterio 3: El servidor db rechaza todas las conexiones entrantes por defecto"

# Verificar política por defecto en db
default_policy=$(vagrant ssh db -c "sudo iptables -L INPUT -n" | grep "policy")
if [[ $default_policy == *"DROP"* || $default_policy == *"REJECT"* ]]; then
    echo "[✔] DB rejects all incoming connections by default."
else
    echo "[✘] DB does not reject all incoming connections by default."
fi