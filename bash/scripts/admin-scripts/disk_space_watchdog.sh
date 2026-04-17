#!/bin/bash

# 1. Get current usage percentage
USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/$//')

if [ "$USAGE" -gt 90 ]; then
  echo "CRITICAL: Disk usage is at ${USAGE}%"
  du -ah /var/log 2>/dev/null | sort -rh | head -n 5 >>disk_report.txt
fi
