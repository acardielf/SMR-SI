#!/bin/bash

echo "Criterio 2: El servidor web puede conectarse al servidor de base de datos db a través del puerto de MariaDB"

# Verificar conexión desde web a db. 
# Netcat con -z indica que no se envía datos, solo se verifica la conexión.
# con -v es verbose
connection=$(vagrant ssh web -c "nc -vz 192.168.56.102 3306" 2>&1)
if [[ $connection == *"succeeded"* ]]; then
    echo "[✔] Web can connect to DB on port 3306."
else
    echo "[✘] Web cannot connect to DB on port 3306."
fi