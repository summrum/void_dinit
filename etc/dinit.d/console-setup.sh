#!/bin/sh
# Code from Void Runit
[ -r /etc/rc.conf ] && . /etc/rc.conf
# Detect LXC (and other) containers
[ -z "${container+x}" ] || export VIRTUALIZATION=1
[ -n "$VIRTUALIZATION" ] && return 0

TTYS=${TTYS:-12}
if [ -n "$FONT" ]; then
    echo "Setting up TTYs font to '${FONT}'"

    _index=0
    while [ ${_index} -le $TTYS ]; do
        setfont ${FONT_MAP:+-m $FONT_MAP} ${FONT_UNIMAP:+-u $FONT_UNIMAP} \
                $FONT -C "/dev/tty${_index}"
        _index=$((_index + 1))
    done
fi

if [ -n "$KEYMAP" ]; then
    echo "Setting up keymap to '${KEYMAP}'"
    loadkeys -q -u ${KEYMAP}
fi

if [ -n "$HARDWARECLOCK" ]; then
    echo "Setting up RTC to '${HARDWARECLOCK}'"
    TZ=$TIMEZONE hwclock --systz \
        ${HARDWARECLOCK:+--$(echo $HARDWARECLOCK |tr A-Z a-z) --noadjfile} || exit 1
fi
