#!/bin/bash

# Configuración
BACKUP_SOURCE="/backups/full/monthly"
BACKUP_DEST="/backups/full/yearly"
PASSWORD="Solucion2025"
DATE=$(date +"%Y")
FILE_NAME="yearly_backup_$DATE.zip"

mkdir -p "$BACKUP_DEST"

LAST_BACKUP=$(ls -t "$BACKUP_SOURCE"/*.zip | head -n 1)
if [ -f "$LAST_BACKUP" ]; then
    cp "$LAST_BACKUP" "$BACKUP_DEST/$FILE_NAME"
    echo "Backup anual realizado: $BACKUP_DEST/$FILE_NAME"
else
    echo "❌ No hay backups mensuales disponibles."
fi

# Limpiar backups antiguos (más de 5 años)
# 365 * 5 = 1825
find "$BACKUP_DEST" -name "*.zip" -mtime +1825 -delete
