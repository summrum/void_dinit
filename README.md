# void_dinit
This repository contains files I used to get Dinit (https://github.com/davmac314/dinit) working as system init on Void Linux (https://voidlinux.org/, https://github.com/void-linux). These have been put together from the Void Runit scripts (https://github.com/void-linux/void-runit), Artix Linux Dinit scripts (https://gitea.artixlinux.org/artixlinux/packages-dinit) and the example services provided with Dinit (https://github.com/davmac314/dinit/tree/master/doc/linux/services). Effectively, all I have done is combine the scripts available from the these sources with just a few very small modifications - all the real work has been carried out by the developers on the aforementioned projects and all credit for this working at all goes to them.

I currently have a (seemingly fully) working KDE Plasma desktop using Pipewire as the audio system with wireless network connectivity on a Void musl system. Runit has been completely uninstalled from this test system using ```ignorepkg=runit``` and ```ignorepkg=runit-void``` in a ```.conf``` file in ```/etc/xbps.d/```. I have not yet attempted to get Bluetooth working (although Dbus appears to be working correctly), nor filesystem encryption or logical volume management. This was purely for fun and to teach myself more about initialising a Linux system; I do not recommend using anything from this repository on anything other than a test system. 

```/etc/*``` are files that need to be placed in to ```/etc/```. I have attempted to maintain some compatibility with the ```/etc/rc.*``` files supplied with Void, and I think that the existing files provided by Void _should_ work without issue (if, for example, Runit is not uninstalled from the system these ```/etc/rc.*``` files will still exist).

```/srcpkgs/dinit/template``` is the template file I used for compiling Dinit using ```xbps-src```. This has built without issue for me on glibc and musl x86_x64 systems; I have not tried for other architectures. After installing Dinit, the system shutdown executables will be replaced so this is probably best carried out from a ```chroot```. Instructions for setting Dinit as the system init on Linux are provided at the Dinit repository (https://github.com/davmac314/dinit/blob/master/doc/linux/DINIT-AS-INIT.md).
