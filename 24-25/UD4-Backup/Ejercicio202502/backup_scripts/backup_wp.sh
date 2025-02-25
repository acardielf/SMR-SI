#!/bin/bash

# Configuración
WP_PATH="/var/www/html"
BACKUP_DIR="/backups/wordpress/daily"
PASSWORD="Solucion2025"
DATE=$(date +"%Y-%m-%d")
FILE_NAME="wp_backup_$DATE.zip"

# Crear directorio si no existe
mkdir -p "$BACKUP_DIR"

# Poner WordPress en modo mantenimiento
wp maintenance-mode activate --path="$WP_PATH"

# Comprimir archivos
zip -r -P "$PASSWORD" "$BACKUP_DIR/$FILE_NAME" "$WP_PATH"

# Salir del modo mantenimiento
wp maintenance-mode deactivate --path="$WP_PATH"

# Limpiar backups antiguos (más de 7 días)
find "$BACKUP_DIR" -name "*.zip" -mtime +7 -delete

echo "Backup de WordPress completado: $BACKUP_DIR/$FILE_NAME"
