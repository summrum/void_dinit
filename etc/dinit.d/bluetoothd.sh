#!/bin/sh
# sleep avoids unreliable dbus connection due to race condition
sleep 0.1s
exec /usr/libexec/bluetooth/bluetoothd -n
