#!/bin/bash

while IFS= read -r line; do
    if [[ "$line" =~ ^[A-Za-z_][A-Za-z0-9_]*= ]]; then
        eval "$line"
    fi
done < <(grep '^[A-Za-z_][A-Za-z0-9_]*=' web.sh)


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

echo "======================================"
echo "Verificación del examen de: $nombre"
echo "======================================"
ejecutar_script ./.scripts/check/script1.sh
echo
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


# Calcular la nota con dos decimales
nota=$(echo "scale=2; $criterios_cumplidos * 10 / 9" | bc)

# Mostrar resumen final
echo "======================================"
echo "Resumen final:"
echo "Criterios cumplidos: $criterios_cumplidos de 9"
echo "Nota: $nota/10"
echo "======================================"