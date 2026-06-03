#!/bin/sh
# Sync files to nextcloud using flock to prevent multiple instances
if ! flock -n /tmp/.sync.lock nextcloudcmd --non-interactive -h -s -u "$NEXTCLOUD_USER" -p "$NEXTCLOUD_PASSWORD" --path "$NEXTCLOUD_REMOTE_PATH" /opt/portfolio/workspace/nextcloud "$NEXTCLOUD_URL"; then
    echo "Sync failed or already in progress"
fi
