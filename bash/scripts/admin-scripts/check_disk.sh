#!/bin/bash

THRESHOLD=80
USAGE=$(df / | awk 'NR==3 {print $5} | tr -d '%')

if [ "$USAGE" -gt "$THRESHOLD" ]; then
	echo "WARNING: Disk usage is at ${USAGE}%"
else
	echo "Disk usage is OK: ${USAGE}%"
fi
