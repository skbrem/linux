#!/bin/bash

THRESHOLD=85
ALERT_EMAIL="admin@example"
HOSTNAME=$(hostname -f)

while read OUTPUT; do
	USAGE=$(echo $OUTPUT | awk '{print $1}' | tr -d '%')
	PARTIION=$(echo $OUTPUT | awk '{print $2}')

	if [ "$USAGE" -ge "$THRESHOLD" ]; then
		MSG="ALERT: $PARTITION on $HOSTNAME is at ${USAGE}% capacity."
		echo $MSG | mail -s "[Disk alert] $HOSTNAME" $ALERT_EMAIL
		echo $MSG
	fi
done < <(df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{print $5 " " $1}')
