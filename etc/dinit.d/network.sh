#!/bin/sh
if [ "$1" != "stop" ]; then
    . /etc/dinit.d/config/network.conf
    if [ -z "$GATEWAY" ]; then
        set -- $(ip route show | grep default)
        GATEWAY="$3"
    fi
    exe
    while ! ping -W 1 -c 1 $GATEWAY; do
    echo "Waiting for network"
    sleep 1
    done
    echo "Network responding"
    exit 0
else
    exit 0
fi
