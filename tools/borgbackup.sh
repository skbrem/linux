#!/usr/bin/env bash

# ---------------
# Backs up the home directory directly to a remote server with BorgBackup.
# ---------------

set -euo pipefail

# --- CONFIGURATION ---
REMOTE_HOST="laptop-server"
REMOTE_REPO="/mnt/backup-storage/main-repo"
TARGET_REPO="${REMOTE_HOST}:${REMOTE_REPO}"

# Passphrase for the encrypted Borg repository
# (Set to empty string if you initialized the repo with --encryption=none)
export BORG_PASSPHRASE="your_secret_passphrase_here"

# ---------------------

# Verify remote host is reachable before starting
if ! ping -c 1 -W 2 "$REMOTE_HOST" >/dev/null 2>&1; then
    echo "Error: Remote host '$REMOTE_HOST' is unreachable."
    exit 1
fi

ARCHIVE_NAME="$(hostname)-{now:%Y-%m-%d}"

echo "Starting Borg backup to '$TARGET_REPO'..."

# Create the backup directly over SSH without generating local archive files
borg create \
    --stats \
    --progress \
    --compression zstd,6 \
    --exclude-caches \
    --exclude "$HOME/.cache" \
    --exclude "$HOME/.local/share/Trash" \
    --exclude "$HOME/Downloads" \
    "${TARGET_REPO}::${ARCHIVE_NAME}" \
    "$HOME"

echo "Pruning old archives to save space..."

# Keep 7 daily, 4 weekly, and 6 monthly snapshots
borg prune \
    --list \
    --prefix "$(hostname)-" \
    --keep-daily=7 \
    --keep-weekly=4 \
    --keep-monthly=6 \
    "${TARGET_REPO}"

echo "Success! Backup complete and pruned."
