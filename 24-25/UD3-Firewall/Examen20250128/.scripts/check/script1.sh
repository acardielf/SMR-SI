#!/bin/bash

echo "Criterio 1: Verificar resolución DNS, conectividad a Internet y tráfico SSH en web y db"

# Función para verificar DNS, conectividad a Internet y tráfico SSH en una máquina
verificar_maquina() {
    maquina=$1
    echo "Verificando máquina: $maquina"

    # 1. Verificar conectividad a Internet
    ping=$(vagrant ssh $maquina -c "curl -sL --connect-timeout 2 --max-time 4 -o /dev/null ifconfig.me" 2>&1)
    if [[ $ping == *"200"* ]]; then
        echo "   [OK] Conectividad a Internet funciona correctamente."
    else
        echo "   [✘] Error en la conectividad a Internet."
        return 1
    fi

    # 3. Verificar tráfico de entrada/salida por SSH
    ssh_input=$(vagrant ssh $maquina -c "sudo iptables -L INPUT -n" | grep "tcp dpt:22")
    ssh_output=$(vagrant ssh $maquina -c "sudo iptables -L OUTPUT -n" | grep "tcp spt:22")

    if [[ $ssh_input == *"ACCEPT"* && $ssh_output == *"ACCEPT"* ]]; then
        echo "   [OK] Tráfico SSH (entrada/salida) permitido."
    else
        echo "   [✘] Error en el tráfico SSH (entrada/salida)."
        return 1
    fi

    echo " - Todas las verificaciones en $maquina fueron exitosas."
    return 0
}

# Verificar máquina web
webok=false
if verificar_maquina "web"; then
    echo "[OK] Máquina web cumple con los requisitos."
    webok=true
fi

echo

# Verificar máquina db
dbok=false
if verificar_maquina "db"; then
    echo "[OK] Máquina db cumple con los requisitos."
    dbok=true
fi

echo 

# Verificar máquinas
if $webok && $dbok; then
    echo "[✔] WEB y DB cumplen con los requisitos."
else
    echo "[✘] Alguna de las máquinas no cumple con los requisitos."
fi
