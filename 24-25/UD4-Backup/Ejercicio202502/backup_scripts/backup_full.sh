#!/bin/bash

# Configuración
WP_PATH="/var/www/html"
DB_NAME="salmedina_db"
DB_USER="salmedina_user"
DB_PASS="salmedina_pass"
BACKUP_DIR="/backups/full/weekly"
PASSWORD="Solucion2025"
DATE=$(date +"%Y-%m-%d")
FILE_NAME="full_backup_$DATE.zip"
TEMP_DIR="/tmp/backup_full_$DATE"
WP_ROOT=/var/www/html

wp() {
    sudo -u www-data /usr/local/bin/wp --path=${WP_ROOT} "$@"
}

# Crear directorios
mkdir -p "$BACKUP_DIR"
mkdir -p "$TEMP_DIR"

# Copiar archivos de WordPress
cp -r "$WP_PATH" "$TEMP_DIR/wordpress"

# Exportar la base de datos
wp maintenance-mode activate
wp db export --add-drop-table "$TEMP_DIR/db_backup.sql"
wp maintenance-mode deactivate

# Comprimir todo con contraseña
zip -r -P "$PASSWORD" "$BACKUP_DIR/$FILE_NAME" "$TEMP_DIR"

# Limpiar archivos temporales
rm -rf "$TEMP_DIR"

# Limpiar backups antiguos (más de 4 semanas)
# 7 * 4 = 28
find "$BACKUP_DIR" -name "*.zip" -mtime +28 -delete

echo "Backup completo realizado: $BACKUP_DIR/$FILE_NAME"
