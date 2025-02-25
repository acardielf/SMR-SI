#!/bin/bash

# Configuración
BACKUP_SOURCE="/backups/full/weekly"
BACKUP_DEST="/backups/full/monthly"
PASSWORD="Solucion2025"
DATE=$(date +"%Y-%m")
FILE_NAME="monthly_backup_$DATE.zip"

# Crear directorio si no existe
mkdir -p "$BACKUP_DEST"

# Copiar el último backup semanal y comprimirlo
LAST_BACKUP=$(ls -t "$BACKUP_SOURCE"/*.zip | head -n 1)
if [ -f "$LAST_BACKUP" ]; then
    cp "$LAST_BACKUP" "$BACKUP_DEST/$FILE_NAME"
    echo "Backup mensual realizado: $BACKUP_DEST/$FILE_NAME"
else
    echo "❌ No hay backups semanales disponibles."
fi

# Limpiar backups antiguos (más de 12 meses)
find "$BACKUP_DEST" -name "*.zip" -mtime +365 -delete
