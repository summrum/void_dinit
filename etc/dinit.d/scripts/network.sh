#!/bin/sh
. /etc/dinit.d/config/network.conf
if [ -z "$GATEWAY" ]; then
    set -- $(ip route show | grep default)
    GATEWAY="$3"
fi
while ! ping -W 1 -c 1 $GATEWAY; do
echo "Waiting for network"
sleep 0.1
done
echo "Network responding"
exit 0
