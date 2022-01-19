#!/bin/sh
# Code from Runit
[ -r /etc/rc.conf ] && . /etc/rc.conf
if [ -n "$HARDWARECLOCK" ]; then
    echo "Setting up RTC to '${HARDWARECLOCK}'..."
    TZ=$TIMEZONE hwclock --systz \
        ${HARDWARECLOCK:+--$(echo $HARDWARECLOCK |tr A-Z a-z) --noadjfile} || exit 1
fi
