#!/bin/bash

set -e

SNAPSHOT_PATH="/home/.snapshot"
BACKUP_DEST="/mnt/critical/backups/pc"
HOME_SUBVOL="/home"
REMOTE_HOST="root@192.168.1.34"

# Cleanup function - runs on exit, error, or interrupt
cleanup() {
    echo "Cleaning up..."

    # Remove snapshot if it exists
    if [ -d "$SNAPSHOT_PATH" ]; then
        echo "Removing snapshot..."
        sudo btrfs subvolume delete "$SNAPSHOT_PATH" 2>/dev/null || true
    fi
}

# Register cleanup on exit, error, and interrupt
trap cleanup EXIT ERR INT TERM

echo "Creating readonly snapshot..."
sudo btrfs subvolume snapshot -r "$HOME_SUBVOL" "$SNAPSHOT_PATH"

echo "Ensuring remote backup directory exists..."
ssh "$REMOTE_HOST" "mkdir -p '$BACKUP_DEST'"

echo "Backing up /home via snapshot..."
sudo rsync -aAXH --delete --progress \
    --partial --timeout=120 \
    --exclude='.snapshot' \
    -e "ssh -o ServerAliveInterval=30 -o ServerAliveCountMax=5" \
    "$SNAPSHOT_PATH/" \
    "$REMOTE_HOST:$BACKUP_DEST/"

echo "Saving package list..."
pacman -Qqe | ssh "$REMOTE_HOST" "cat > '$BACKUP_DEST/pkglist.txt'"

echo "Backup complete!"
