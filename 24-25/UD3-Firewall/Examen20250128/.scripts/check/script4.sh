#!/bin/bash

echo "Criterio 4: El servidor db acepta todas las conexiones salientes por defecto"

# Verificar política por defecto en db
default_policy=$(vagrant ssh db -c "sudo iptables -L OUTPUT -n" | grep "policy")
if [[ $default_policy == *"ACCEPT"* ]]; then
    echo "[✔] DB accepts all outgoing connections by default."
else
    echo "[✘] DB does not accept all outgoing connections by default."
fi