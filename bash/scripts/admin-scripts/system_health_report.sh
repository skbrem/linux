#!/bin/bash

# health_report.sh - a quick server health snapshot

echo "===== System Health Report: $(date) ======"
echo

echo "--- Hostname ---"
hostname -f

echo "--- Uptime ---"
uptime

echo "--- CPU Load (1/5/15 min) ---"
cat /proc/loadavg | awk '{print "Load: "$1" / "$2" / "$3}'

echo "--- Memory usage ---"
free -h | grep Mem

echo "--- Disk usage ---"
df -h | grep -v tmpfs

echo "--- Top 5 Processes by CPU ---"
ps aux --sort=%cpu | head -6

echo "==============================="
