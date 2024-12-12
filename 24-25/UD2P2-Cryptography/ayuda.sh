#!/bin/bash

# ofuscado y ejecutado:
#
# echo '#!/usr/bin/env bash' &gt; UD2P1_assimetric_obfuscated.sh
# echo "bash &lt;(echo '$(base64 UD2P1_assimetric.sh)' | base64 -d)" &gt;&gt; UD2P1_assimetric_obfuscated.sh
# chmod +x UD2P1_assimetric_obfuscated.sh
# gpg --encrypt --recipient si_ud2p1@iessalmedina.es --armor UD2P1_assimetric_obfuscated.sh
# ./UD2P1_assimetric_obfuscated.sh

mensaje_bienvenida="¡Bien! ¡Has conseguido descifrar adecuadamente este fichero!"
mensaje_instrucciones="Para continuar con el ejercicio pega el siguiente texto en la caja de respuesta:"

fecha_hora=$(date +"%Y-%m-%d %H:%M:%S")
hostname=$(hostname)
ip=$(hostname -I | awk '{print $1}')
sistema_operativo=$(lsb_release -d | awk -F"\t" '{print $2}')
kernel=$(uname -r)


clear

echo "$mensaje_bienvenida"
echo "$mensaje_instrucciones"
echo ""
echo ""
echo "Usuario: $USER"
echo "Fecha y hora: $fecha_hora"
echo "Hostname: $hostname"
echo "IP: $ip"
echo "SO: $sistema_operativo"
echo "Kernel: $kernel"
echo ""