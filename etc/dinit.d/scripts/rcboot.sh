#!/bin/sh
# code from Void Runit
# Detect LXC (and other) containers
[ -z "${container+x}" ] || export VIRTUALIZATION=1
if [ "$1" != "stop" ]; then
  install -m0664 -o root -g utmp /dev/null /run/utmp
 
  if [ -z "$VIRTUALIZATION" ]; then
  # Configure random seed (updated to use seedrng as Void Runit)
      echo "Seeding random number generator..."
      seedrng || true
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
    	seedrng || true
    fi
fi
