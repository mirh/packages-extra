## Untested (and unfinished)

Somehow, my HD 7750 didn't seem to be recognized ("no supported adapters detected"), despite the kernel module loading properly. I don't have aged enough hardware, so take it half-assed this way, and without much care for 32-bit or CL. 

You can (try to) install the drivers like so:
```
./build-catalyst-legacy.sh
sudo pacman -Sy mhwd-catalyst-legacy
sudo mhwd -i pci video-catalyst-legacy
```
I'd expect most of the "normal catalyst" [info](../catalyst/README.md) (and much more) to apply here too. 

p.s. If you don't want mhwd to complain about missing packages for the other kernels you may have, delete [this line](https://gitlab.manjaro.org/applications/mhwd/-/blob/0.6.3/scripts/mhwd#L268). 

### Uninstall

Since mhwd is on life support since like 2017, you'll need to use a bit of forcing here:
```
sudo pacman -Sdd xorg-server xorg-server xorg-server-common xf86-input-libinput
sudo pacman -R xorg-server1.12-devel
sudo mhwd -r pci video-catalyst-legacy
```
