#!/bin/bash

# Inicializar contador de criterios cumplidos
criterios_cumplidos=0

# Función para ejecutar un script y contar los criterios cumplidos
ejecutar_script() {
    output=$("$@")  # Ejecutar el script y capturar la salida
    echo "$output"  # Mostrar la salida del script

    # Contar los [✔] en la salida
    if [[ $output == *"[✔]"* ]]; then
        criterios_cumplidos=$((criterios_cumplidos + 1))
    fi
}

# Ejecutar cada script
echo
ejecutar_script ./.scripts/check/script2.sh
echo
echo
ejecutar_script ./.scripts/check/script3.sh
echo
echo
ejecutar_script ./.scripts/check/script4.sh
echo
echo
ejecutar_script ./.scripts/check/script5.sh
echo
echo
ejecutar_script ./.scripts/check/script6.sh
echo
echo
ejecutar_script ./.scripts/check/script7.sh
echo
echo
ejecutar_script ./.scripts/check/script8.sh
echo
echo
ejecutar_script ./.scripts/check/script9.sh

# Mostrar resumen final
echo "======================================"
echo "Resumen final:"
echo "Criterios cumplidos: $criterios_cumplidos de 8"
echo "Nota: $((criterios_cumplidos * 10 / 8))/10"
echo "======================================"