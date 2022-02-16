# This is the primary service, automatically started when the system comes up.

type = internal

# Each of these services starts a login prompt:
depends-ms = tty1
depends-ms = tty2
depends-ms = tty3
depends-ms = tty4
depends-ms = tty5
depends-ms = tty6

# Required for boot
depends-ms = rcboot
depends-ms = auxfilesystems
depends-ms = sysctl
depends-ms = cleanup
depends-ms = locale
depends-ms = rclocal

# the boot.d directory will launch user-specified services:
waits-for.d = boot.d
