#!/bin/sh
. /etc/dinit.d/config/wpa_supplicant.conf
exec /usr/bin/wpa_supplicant -i "${WPA_INTERFACE}" -c /etc/wpa_supplicant/wpa_supplicant-"${WPA_INTERFACE}".conf
