#!/usr/bin/env bash

set -euo pipefail

COMPOSE_DIR="/srv/compose/minecraft"
DATA_DIR="/srv/minecraft/data"
BACKUP_DIR="/srv/minecraft/backups"

TIMESTAMP="$(date '+%Y-%m-%d_%H-%M-%S')"
BACKUP_FILE="$BACKUP_DIR/minecraft-$TIMESTAMP.tar.gz"

echo "[$(date)] Iniciando backup do Minecraft..."

mkdir -p "$BACKUP_DIR"

cd "$COMPOSE_DIR"

docker compose stop minecraft

tar -czf "$BACKUP_FILE" \
    -C "$DATA_DIR" \
    worlds \
    server.properties \
    allowlist.json \
    permissions.json

docker compose start minecraft

echo "[$(date)] Backup criado: $BACKUP_FILE"

find "$BACKUP_DIR" \
    -type f \
    -name 'minecraft-*.tar.gz' \
    -mtime +14 \
    -delete

echo "[$(date)] Backup concluído."