#!/bin/sh

start_pp() {
    #change to workdpace dir, so that file open dialog in pp will show up mounted dir in left menu
    cd /opt/portfolio/workspace
    #start application
    exec /opt/portfolio/PortfolioPerformance > /config/log/pp_out.log 2> /config/log/pp_err.log
}

start_ff() {
    # Create a default Firefox profile
    #mkdir -p /root/.mozilla/firefox
    firefox -CreateProfile "default /root/.mozilla/firefox/default"
    # Start firefox-esr
    firefox-esr &
}

# start firefox
#start_ff

# Starten Sie ein Panel (z.B. tint2)
tint2 &

# start portfolio performance
start_pp