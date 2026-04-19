#!/bin/bash

set -euo pipefail

SOURCE_DIR="/var/www/html"
BACKUP_DIR="/backups/web"
RETENTION_DAYS=7
DATE=$(date +%Y-%m-%d_%H%M%s)
ARCHIVE="${BACKUP_DIR}/web_backup_${DATE}.tar.gz"
LOG_FILE="/var/log/backup.log"

# Create a backup directory if it doesn't exist

mkdir -p $BACKUP_DIR

echo "[$DATE}] Starting backup of $SOURCE_DIR | tee -a $LOG_FILE"

# Create a compressed archive

if tar -czf $ARCHIVE $SOURCE_DIR 2>>$LOG_FILE; then
	echo "Backup created: $ARCHIVE" | tee -a $LOG_FILE
else
       	echo "ERROR: Backup failed." | tee -a $LOG_FILE
fi

# Remove old backups

find $BACKUP_DIR -name "*.tar.gz" -mtime +$RETENTION_DAYS -delete
echo "Old backups cleaned up. Done." | tee -a $LOG_FILE
