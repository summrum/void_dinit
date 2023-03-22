# void_dinit
#### PLEASE NOTE: This is not affiliated with, or supported in any way by, Void Linux 
This repository contains files I used to get [Dinit](https://github.com/davmac314/dinit) working as system init on [Void Linux](https://voidlinux.org/). These have been put together mainly from the [Void Runit scripts](https://github.com/void-linux/void-runit), with a lot of help also from the [Artix Linux Dinit services and scripts](https://gitea.artixlinux.org/artixlinux/packages-dinit) and the [example services provided with Dinit](https://github.com/davmac314/dinit/tree/master/doc/linux/services). Effectively, all I have done is combine the scripts and service templates available from the these sources with just a few very small modifications - all the real work has been carried out by the developers on the aforementioned projects and all credit for any of this even working at all goes to them.

```/etc/*``` are service files to be placed in to ```/etc/```. I have attempted to maintain some compatibility with the ```/etc/rc.*``` files supplied with Void, and I think that the existing files provided by Void _should_ work without issue (if, for example, Runit is not uninstalled from the system these ```/etc/rc.*``` files will still exist). All services I deemed required for boot are started via reference in the ```/etc/dinit.d/boot``` service or via dependencies  of these (note: not entirely true, some of the services being started could techincally be disabled). There are also various other service files that I have tested (but far from an exhaustive list) that are not symlinked/activated by default in this repository. In ```/etc/dinit.d/config``` there are config files for the late-filesystems, network check and wpa_supplicant services.

```/user/dinit.d/*``` are user service file examples that I am using to start pipewire, pipewire-pulse and wireplumber and need to be placed in ```$HOME/.config/dinitd.d/``` to be used. I am starting a user instance of Dinit from my ```.bash_profile```. 

```/srcpkgs/dinit/template``` is the template file I used for compiling Dinit using ```xbps-src```. This has built without issue for me on glibc and musl x86_x64 systems; I have not tried for other architectures. After installing Dinit, the system shutdown executables will be replaced so this is probably best carried out from a ```chroot``` (or at least making copies of the originals). [Instructions for setting Dinit as the system init on Linux](https://github.com/davmac314/dinit/blob/master/doc/linux/DINIT-AS-INIT.md) are provided at the Dinit repository. 

I am currently using the Void Linux version of [SeedRNG](https://git.zx2c4.com/seedrng/about/) to generate Kernel RNG and have a fork of the Dinit Master repository to combine this for the time being; the ```/srcpkgs/dinit/template``` file points to my forked repository [seedrng branch](https://github.com/summrum/dinit/tree/seedrng). The ```/srcpkgs/dinit/template-old``` file points to the current release of Dinit at the original Dinit repository which can alternatively be used. If you do not wish to use SeedRNG, the ```/etc/dinit.d/scripts/rcboot-old.sh``` file can be used to replace ```/etc/dinit.d/scripts/rcboot.sh``` (i.e. rename ```rcboot-old.sh``` to ```rcboot.sh```). Note also that Void Runit combines SeedRNG and this exectuable will still be on the system if the ```runit-void``` package has not been removed (so could be used instead of sourcing from my seedrng branch).

I have tested KDE Plasma, Openbox/Tint2/Picom and i3/i3blocks/rofi/Picom setups, launchable from ```startx``` or SDDM, using Pipewire as the audio system with bluetooth and wireless network connectivity (Bluez, NetworkManager, wpa_supplicant, dhcpcd services working) on a Void musl system. All appear to be fully working and I am currently running the i3/i3blocks/rofi/Picom setup as a daily driver. Runit has been completely uninstalled from this test system using ```ignorepkg=runit``` and ```ignorepkg=runit-void``` in a ```.conf``` file in ```/etc/xbps.d/```. 

## DISCLAIMER/WARNING
This was purely for fun and to teach myself more about initialising a Linux system; I do not recommend using anything from this repository on anything other than a test system. I am not affiliated with any of the projects mentioned, none of this repository is supported by those projects, and I have no professional background in programming (just read a few ```man``` pages). You have been warned...

## LICENSE
The [Void Runit scripts](https://github.com/void-linux/void-runit) that this repository is primarily based on (and would not be possible without) are released in the public domain; to the extent possible under law, I waive all copyright to this derivative work and dedicate it to the public domain.
