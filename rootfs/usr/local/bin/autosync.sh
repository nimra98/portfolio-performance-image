#!/bin/sh
# every 5 minutes call start_sync.sh
while true; do
    /usr/local/bin/start_sync.sh
    sleep 300
done
