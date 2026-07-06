#!/bin/bash
set -e
export MSYS_NO_PATHCONV=1 # Tells Git Bash NOT to convert Linux paths to Windows paths

BACKUP_DIR="./backups"
mkdir -p "$BACKUP_DIR"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
FILENAME="$BACKUP_DIR/backup_$TIMESTAMP.dump"

echo "=== [START] Initiating Volume-Isolated Backup ==="

docker exec -i local_postgres pg_dump -U devops_user -d booking_db -F c -f /tmp/backup.dump
docker cp local_postgres:/tmp/backup.dump "$FILENAME"
docker exec -i local_postgres rm /tmp/backup.dump

echo "=== [SUCCESS] Binary backup safely pulled to: $FILENAME ==="