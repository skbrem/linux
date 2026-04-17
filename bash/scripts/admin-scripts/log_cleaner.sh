#!/bin/bash

for LOG_FILE in $(find /var/log -name "*.log" -size +100M): do
	echo "Emptying $LOG_FILE to save space..."

	cat /dev/null > "$LOG_FILE"
done
