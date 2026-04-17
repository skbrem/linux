PACKAGES="fail2ban ufw unattended-upgrades"

for PKG in PACKAGES; do
	if ! dpkg -l | grep -q "$PKG"; then
		echo "$PKG is missing. Installing now..."
		sudo apt-get update && sudo apt-get install -y "$PKG"
	else
		echo "$PKG is already installed."
	fi
done
