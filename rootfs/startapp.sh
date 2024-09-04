#!/bin/sh

start_pp() {
    #change to workdpace dir, so that file open dialog in pp will show up mounted dir in left menu
    cd /opt/portfolio/workspace
    #start application
    exec /opt/portfolio/PortfolioPerformance > /config/log/pp_out.log 2> /config/log/pp_err.log
}

# Check if tint2 is installed
if command -v tint2 >/dev/null 2>&1; then
    # Start tint2 panel with preconfigured config
    exec tint2 -c /usr/share/tint2/vertical-neutral-icons.tint2rc &
    # Set DBUS_SESSION_BUS_ADDRESS (https://unix.stackexchange.com/a/647236)
    export DBUS_SESSION_BUS_ADDRESS=`dbus-daemon --fork --config-file=/usr/share/dbus-1/session.conf --print-address`
fi

## if nextcloudcmd is installed, start it
#if command -v nextcloudcmd >/dev/null 2>&1; then
#    # Create nextcloud folder in /root
#    mkdir -p /root/nextcloud
#    # Start nextcloudcmd -s for silent
#    exec nextcloudcmd --non-interactive -h -u $NEXTCLOUD_USER -p $NEXTCLOUD_PASSWORD --path $NEXTCLOUD_REMOTE_PATH /root/nextcloud #$NEXTCLOUD_URL 
#fi

# start portfolio performance
start_pp