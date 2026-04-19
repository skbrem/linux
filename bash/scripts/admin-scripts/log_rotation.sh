#!/bin/bash

LOG_DIR="/var/log/myapp"
COMPRESS_AFTER=3 # This compresses logs that are older than 3 days
DELETE_AFTER=30 # Deletes logs that are older than 30 days

echo "Log cleanup started: $(date)"

# Compress uncompressed logs older than COMPRESS_AFTER days

find $LOG_DIR -name "*.log" -mtime +$COMPRESS_AFTER | while read f; do
	gzip -9 "$f"
	echo "Compressed: $f"
done

# Remove compressed archives older than DELETE_AFTER days

find $LOG_DIR -name "*.gz" -mtime +$DELETE_AFTER -delete
echo "Cleanup complete."
