#!/bin/sh
# code from Void Runit
# Detect LXC (and other) containers
[ -z "${container+x}" ] || export VIRTUALIZATION=1
if [ "$1" != "stop" ]; then
  install -m0664 -o root -g utmp /dev/null /run/utmp
 
  if [ -z "$VIRTUALIZATION" ]; then
  # Configure random seed (modified to read poolsize, not updated to use seedrng as Void Runit)
  umask 077
  bytes="$(cat /proc/sys/kernel/random/poolsize)" || bytes=512
  cp /var/lib/random-seed /dev/urandom >/dev/null 2>&1 || true
  dd if=/dev/urandom of=/var/lib/random-seed count=1 bs=$bytes >/dev/null 2>&1
  fi

  # Configure network
  ip link set up dev lo


  [ -r /etc/hostname ] && read -r HOSTNAME < /etc/hostname
  if [ -n "$HOSTNAME" ]; then
      echo "Setting up hostname to '${HOSTNAME}'..."
      printf "%s" "$HOSTNAME" > /proc/sys/kernel/hostname
  else
      echo "Didn't setup a hostname!"
  fi
  if [ -f /etc/localtime ]; then
	  loc_set=$(readlink -f /etc/localtime)
      set_zone=$(echo "$loc_set" | sed s%"/usr/share/zoneinfo/"%""%g)
      echo "Timezone set to '${set_zone}'"
  else
      [ -r /etc/rc.conf ] && . /etc/rc.conf
      echo "Setting timezone to '${TIMEZONE}'..."
      ln -sf "/usr/share/zoneinfo/$TIMEZONE" /etc/localtime
  fi

else
    # The system is being shut down
    if [ -z "$VIRTUALIZATION" ]; then
    	echo "Saving random number seed"
    	umask 077
    	bytes=$(cat /proc/sys/kernel/random/poolsize) || bytes=512
    	dd if=/dev/urandom of=/var/lib/random-seed count=1 bs=$bytes >/dev/null 2>&1
    fi
fi
