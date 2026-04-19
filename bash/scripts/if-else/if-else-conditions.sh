#!/bin/bash

FILE="/etc/nginx/nginx.conf"

if [ -f "$FILE" ]; then
	echo "Config file found. Reloading nginx..."
	systemctl reload nginx
elif [ -d "/etc/nginx/" ]; then
	echo "Nginx dir exists but the config is missing."
	exit 1
else
	echo "Nginx not installed"
	exit 2
fi
