#!/bin/bash

echo "Criterio 9: Fail2Ban en db ignora las conexiones incorrectas que procedan de web"

# Verificar regla de ignorar en Fail2Ban
ignore_rule=$(vagrant ssh db -c "sudo cat /etc/fail2ban/jail.local" | grep "ignoreip\s*=\s*192.168.56.101")
if [[ $ignore_rule ]]; then
    echo "[✔] Fail2Ban ignores incorrect connections from web."
else
    echo "[✘] Fail2Ban does not ignore incorrect connections from web."
fi