#!/bin/bash
set -e

# Ensure script is run as root so long backups do not hit a sudo timeout
# before cleanup or package list export.
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root (e.g., sudo ./scripts/backup-home.sh)"
  exit 1
fi

SNAPSHOT_PATH="/home/.snapshot"
BACKUP_DEST="/mnt/critical/backups/pc"
HOME_SUBVOL="/home"
REMOTE_HOST="root@192.168.30.69"

# Cleanup function - runs on exit or interrupt
cleanup() {
    echo "Cleaning up..."
    # Remove snapshot if it exists
    if [ -d "$SNAPSHOT_PATH" ]; then
        echo "Removing snapshot..."
        btrfs subvolume delete "$SNAPSHOT_PATH" 2>/dev/null || true
    fi
}

# Register cleanup on exit and interrupt
trap cleanup EXIT INT TERM

if [ -e "$SNAPSHOT_PATH" ]; then
    echo "Snapshot path already exists: $SNAPSHOT_PATH"
    echo "Remove it before running this backup."
    exit 1
fi

echo "Creating readonly snapshot..."
btrfs subvolume snapshot -r "$HOME_SUBVOL" "$SNAPSHOT_PATH"

echo "Ensuring remote backup directory exists..."
ssh "$REMOTE_HOST" "mkdir -p '$BACKUP_DEST'"

echo "Backing up /home via snapshot..."
# --delete requires BACKUP_DEST to be dedicated to this backup.
rsync -aAXH --delete --progress \
    --partial --timeout=120 \
    --exclude='.cache/' \
    --exclude='.local/share/Trash/' \
    --exclude='**/.gvfs/' \
    -e "ssh -o ServerAliveInterval=30 -o ServerAliveCountMax=5" \
    "$SNAPSHOT_PATH/" \
    "$REMOTE_HOST:$BACKUP_DEST/"

echo "Saving package list..."
pacman -Qqe | ssh "$REMOTE_HOST" "tmp='$BACKUP_DEST/pkglist.txt.tmp' && cat > \"$tmp\" && mv \"$tmp\" '$BACKUP_DEST/pkglist.txt'"

echo "Backup complete!"
