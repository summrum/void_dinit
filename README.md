# void_dinit
This repository contains files I used to get Dinit (https://github.com/davmac314/dinit) working as system init on Void Linux (https://voidlinux.org/, https://github.com/void-linux). These have been put together mainly from the Void Runit scripts (https://github.com/void-linux/void-runit), with a lot of help also from the Artix Linux Dinit services and scripts (https://gitea.artixlinux.org/artixlinux/packages-dinit) and the example services provided with Dinit (https://github.com/davmac314/dinit/tree/master/doc/linux/services). Effectively, all I have done is combine the scripts and service templates available from the these sources with just a few very small modifications - all the real work has been carried out by the developers on the aforementioned projects and all credit for any of this even working at all goes to them.

```/etc/*``` are service files to be placed in to ```/etc/```. I have attempted to maintain some compatibility with the ```/etc/rc.*``` files supplied with Void, and I think that the existing files provided by Void _should_ work without issue (if, for example, Runit is not uninstalled from the system these ```/etc/rc.*``` files will still exist). All services I deemed required for boot are started via reference in the ```/etc/dinit.d/boot``` service or via dependencies  of these (note: not entirely true, some of the services being started could techincally be disabled). Services I deemed optional are symlinked in the ```/etc/dinit.d/boot.d``` directory; currently, only the network service which checks for Gateway response is linked in there.

```/srcpkgs/dinit/template``` is the template file I used for compiling Dinit using ```xbps-src```. This has built without issue for me on glibc and musl x86_x64 systems; I have not tried for other architectures. After installing Dinit, the system shutdown executables will be replaced so this is probably best carried out from a ```chroot```. Instructions for setting Dinit as the system init on Linux are provided at the Dinit repository (https://github.com/davmac314/dinit/blob/master/doc/linux/DINIT-AS-INIT.md).

I have had a (seemingly fully) working KDE Plasma desktop, launchable from ```startx``` or SDDM, using Pipewire as the audio system with bluetooth and wireless network connectivity (NetworkManager and wpa_supplicant services both work) on a Void musl system. I am currently running an (also seemingly fully working) OpenBox/Picom setup without issue. Runit has been completely uninstalled from this test system using ```ignorepkg=runit``` and ```ignorepkg=runit-void``` in a ```.conf``` file in ```/etc/xbps.d/```. I have not yet attempted to get filesystem encryption or logical volume management working. This was purely for fun and to teach myself more about initialising a Linux system; I do not recommend using anything from this repository on anything other than a test system. I am not affiliated with any of the projects mentioned, none of this repository is supported by those projects, and I have no professional background in programming (just read a few ```man``` pages). You have been warned...

## LICENSE
The Void-Runit scripts that this repository is primarily based on (and would not be possible without) are released in the public domain; to the extent possible under law, I waive all copyright to this work and dedicate it to the public domain.
