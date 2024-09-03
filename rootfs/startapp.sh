#!/bin/sh

start_pp() {
    #change to workdpace dir, so that file open dialog in pp will show up mounted dir in left menu
    cd /opt/portfolio/workspace
    #start application
    exec /opt/portfolio/PortfolioPerformance > /config/log/pp_out.log 2> /config/log/pp_err.log
}

# Starten tint2 panel with preconfigured config
exec tint2 -c /usr/share/tint2/vertical-neutral-icons.tint2rc &

# Set DBUS env DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1003/bus (https://unix.stackexchange.com/a/647236)
export DBUS_SESSION_BUS_ADDRESS=`dbus-daemon --fork --config-file=/usr/share/dbus-1/session.conf --print-address`

# start portfolio performance
start_pp