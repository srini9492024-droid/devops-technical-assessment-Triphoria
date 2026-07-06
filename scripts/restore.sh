#!/bin/bash
set -e
export MSYS_NO_PATHCONV=1 # Tells Git Bash NOT to convert Linux paths to Windows paths

if [ -z "$1" ]; then
  echo "[-] Error: Missing target backup filepath."
  echo "Usage: ./scripts/restore.sh ./backups/backup_xxxxxx.dump"
  exit 1
fi

BACKUP_FILE=$1

echo "=== [1/4] Uploading Binary Snapshot to Container ==="
docker cp "$BACKUP_FILE" local_postgres:/tmp/restore.dump

echo "=== [2/4] Purging Existing Data Layer ==="
docker exec -i local_postgres dropdb -U devops_user --if-exists booking_db

echo "=== [3/4] Building Empty Instance Structure ==="
docker exec -i local_postgres createdb -U devops_user booking_db

echo "=== [4/4] Executing Isolated pg_restore ==="
docker exec -i local_postgres pg_restore -U devops_user -d booking_db /tmp/restore.dump
docker exec -i local_postgres rm /tmp/restore.dump

echo "=== [SUCCESS] Data layer successfully restored! ==="