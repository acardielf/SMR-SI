#!/bin/bash

echo "Criterio 7: Acceso desde el host al servidor web y ver 'Éxito' en un fondo verde"

# Verificar acceso desde el host
response=$(curl -s http://192.168.56.101)
if [[ $response == *"Éxito"* ]]; then
    echo "[✔] Host can access web server and see 'Éxito'."
else
    echo "[✘] Host cannot access web server or does not see 'Éxito'."
fi