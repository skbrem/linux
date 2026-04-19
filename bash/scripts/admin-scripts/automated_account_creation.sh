#!/bin/bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <username>"
  exit 1
fi

USERNAME="$1"                        # The username added when running the command
TEMP_PASS=$(openssl rand -base64 12) # A temp password automatically created for the new user

# Creating a user with a home directory
useradd -m -s /bin/bash $USERNAME
echo "${USERNAME}:${TEMP_PASS}" | chpasswd

# Force password change on first login
passwd --expire $USERNAME

# Add to sudo group
usermod -aG sudo $USERNAME

# Set up ssh directory
mkdir -p /home/$USERNAME/.ssh
chmod 700 /home/$USERNAME/.ssh
chown -R ${USERNAME}:${USERNAME} /home/$USERNAME/.ssh

echo "User '$USERNAME' created. Temp password: $TEMP_PASS"
echo "User will be prompted to change password on first login."
