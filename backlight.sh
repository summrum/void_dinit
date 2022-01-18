#!/bin/sh
if [ "$1" != "stop" ]; then
    # Restore saved brightness for each card, if any.
    for card in $(find /sys/class/backlight/ -type l); do
        storage_file="/var/cache/backlight/$(basename $card)-brightness-old"
        if [ -r "$storage_file" ]; then
            cp "$storage_file" "$card/brightness"
        fi
    done
else
    [ ! -d /var/cache/backlight ] && mkdir -p /var/cache/backlight
    [ ! -w /var/cache/backlight ] && chmod 755 /var/cache/backlight
    # Save current brightness of each card.
    for card in $(find /sys/class/backlight/ -type l); do
        cp "$card/brightness" "/var/cache/backlight/$(basename $card)-brightness-old"
    done
fi
