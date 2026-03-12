#!/bin/bash
set -e

# Ensure script is run as root to avoid sudo timeouts during cleanup
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root (e.g., sudo ./backup.sh)"
  exit 1
fi

SNAPSHOT_PATH="/home/.snapshot"
BACKUP_DEST="/mnt/critical/backups/pc"
HOME_SUBVOL="/home"
REMOTE_HOST="root@192.168.30.69"

# Cleanup function - runs on exit, error, or interrupt
cleanup() {
    echo "Cleaning up..."
    # Remove snapshot if it exists
    if [ -d "$SNAPSHOT_PATH" ]; then
        echo "Removing snapshot..."
        btrfs subvolume delete "$SNAPSHOT_PATH" 2>/dev/null || true
    fi
}

# Register cleanup on exit, error, and interrupt
trap cleanup EXIT ERR INT TERM

echo "Creating readonly snapshot..."
btrfs subvolume snapshot -r "$HOME_SUBVOL" "$SNAPSHOT_PATH"

echo "Ensuring remote backup directory exists..."
ssh "$REMOTE_HOST" "mkdir -p '$BACKUP_DEST'"

echo "Backing up /home via snapshot..."
# Removed sudo (since script is run as root)
# Added standard exclusions to save time/space
rsync -aAXH --delete --progress \
    --partial --timeout=120 \
    --exclude='.cache/' \
    --exclude='.local/share/Trash/' \
    --exclude='**/.gvfs/' \
    -e "ssh -o ServerAliveInterval=30 -o ServerAliveCountMax=5" \
    "$SNAPSHOT_PATH/" \
    "$REMOTE_HOST:$BACKUP_DEST/"

echo "Saving package list..."
# Getting pacman list (note: run as root, this behaves the same)
pacman -Qqe | ssh "$REMOTE_HOST" "cat > '$BACKUP_DEST/pkglist.txt'"

echo "Backup complete!"
