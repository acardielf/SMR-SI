#!/bin/bash

# Configuración
DB_NAME="salmedina_db"
DB_USER="salmedina_user"
DB_PASS="salmedina_pass"
BACKUP_DIR="/backups/mysql/hourly"
PASSWORD="Solucion2025"
DATE=$(date +"%Y-%m-%d_%H-%M")
FILE_NAME="db_backup_$DATE.sql"

# Crear directorio si no existe
mkdir -p "$BACKUP_DIR"

# Exportar la base de datos
wp maintenance-mode activate
wp db export --add-drop-table "$BACKUP_DIR/$FILE_NAME"
wp maintenance-mode deactivate

# Comprimir con contraseña
zip -P "$PASSWORD" "$BACKUP_DIR/$FILE_NAME.zip" "$BACKUP_DIR/$FILE_NAME"

# Eliminar el archivo SQL sin comprimir
rm "$BACKUP_DIR/$FILE_NAME"

# Limpiar backups antiguos (más de 7 días)
find "$BACKUP_DIR" -name "*.zip" -mtime +7 -delete

echo "Backup de base de datos completado: $BACKUP_DIR/$FILE_NAME.zip"
