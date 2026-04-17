#!/bin/bash

DB_CONFIG="etc/mariadb/db.conf"

[[ ! -r "$DB_CONFIG" ]] || { echo "Access denied"; && exit 1; }

echo "Access verified"
exit 0
