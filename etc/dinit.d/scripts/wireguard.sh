#!/bin/sh
case "$1" in
    start)
		for conf in /etc/wireguard/*.conf; do
			[ -e "$conf" ] || continue;
			wg-quick up "$conf"
		done
		;;
	stop)	
		for conf in /etc/wireguard/*.conf; do
			[ -e "$conf" ] || continue;
			wg-quick down "$conf"
		done
		;;
esac
