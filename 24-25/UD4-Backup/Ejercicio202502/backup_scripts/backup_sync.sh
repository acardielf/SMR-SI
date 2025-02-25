#!/bin/bash

# Configuración
LOCAL_BACKUP_DIR="/backups"
REMOTE_USER="usuario"
REMOTE_HOST="vm2"
REMOTE_DIR="/backups_remotos"
SSH_PORT="22"

# Opciones de rsync:
# -avz  → Archivo, verbose, comprimir
# --delete  → Elimina en destino los archivos que ya no existen en origen
# --progress → Muestra progreso de transferencia
rsync -avz --delete --progress -e "ssh -p $SSH_PORT" "$LOCAL_BACKUP_DIR/" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/"

# Verificación
if [ $? -eq 0 ]; then
    echo "✅ Sincronización completada con éxito."
else
    echo "❌ Error en la sincronización."
fi
