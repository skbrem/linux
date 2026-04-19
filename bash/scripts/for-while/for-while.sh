#!/bin/bash

# Loop through a list of servers
for server in web01 web02 web03 db01; do
	echo "Pinging server"
	ping -c 1 $SERVER &>/dev/null && echo "$SERVER" is up" || echo "$SERVER" is down"
done

# While loop - retry until success
RETRIES=0
while ! systemctl is-active --quiet mysql; do
	echo "MySQL not ready. Retrying... ($RETRIES)"
	sleep 5
	((RETRIES++))
	[ $RETRIES -ge 5 ] && echo "Giving up." && exit 1
done
echo "MySQL is running."
