#!/bin/bash

# PURPOSE
# ============================================================================================
# A simple script that archives and compresses a file, and then sends it off to my home server
# ============================================================================================

set -e

# --- CONFIGURATION ---
REMOTE_HOST="laptop-server"
REMOTE_DEST="/home/sean/backup"
# ---------------------

# 1. Check if the correct number of arguments are passed
if [ "$#" -ne 1 ]; then
    echo "Usage :$0 <directory_to_compress>"
    exit 1
fi

INPUT_DIR="$1"

# 2. Verify that target is a directory
if [ ! -d "$INPUT_DIR"]; then
    echo "Error: Directory '$INPUT_DIR' does not exist."
    exit 1
fi

INPUT_DIR="${INPUT_DIR%/}"
TIMESTAMP=$(date +%F)
OUTPUT_ARCHIVE="${INPUT_DIR}-${TIMESTAMP}.tar.zst"

# 3. Compress the dir locally
echo "Compressing '$INPUT_DIR' into '$OUTPUT_ARCHIVE'..."
tar --zstd -cf "$OUTPUT_ARCHIVE" "$INPUT_DIR"
echo "Local compression complete."

# 4. Transfer to home server
echo "Sending '$OUTPUT_ARCHIVE' to '$REMOTE_HOST:$REMOTE_DEST'..."
scp "$OUTPUT_ARCHIVE" "$REMOTE_HOST:$REMOTE_DEST"

rm "$OUTPUT_ARCHIVE"

echo "Success! Backup safely transferred to server."
