
You can install the drivers like so:
```
./build-catalyst.sh
sudo pacman -Sy mhwd-catalyst
sudo mhwd -i pci video-catalyst
```

⚠️: SDDM is broken for some reason (and [possibly](https://aur.archlinux.org/packages/catalyst-fix-gdm/) also GDM). Please switch to another display manager like for example LightDM. 

Xfce and KDE have been tested to work properly with that. 

**Notes:**
* *ASIC hang* errors should be due to [overheating](https://bugs.launchpad.net/ubuntu/+source/mesa/+bug/881526/comments/56). Or some [sneaky](https://github.com/xbmc/xbmc/pull/1649) bug. I only got this once, cannot reproduce it anymore. 
* If your kernel is compiled with CONFIG_DEBUG_PREEMPT, you should see `BUG: using smp_processor_id() in preemptible` warnings on boot. They are ugly but ideally harmless. 
* There is a 5.4 folder, but I'm too lame to fix the breakage by torvalds/linux@a919198b
* Similarly, I know torvalds/linux@4949148a is responsible for `BUG: Bad page map` [errors](https://forum.manjaro.org/t/constant-bad-page-map-errors/57659) since kernel 4.8, but I'm [totally](https://lkml.org/lkml/2016/8/8/723) [clueless](https://patchwork.kernel.org/patch/9298497/) on how they should be handled. They aren't good, but after like a year of usage they never seemed anything major. 
* Performance (at least in Unigine Heaven) between 3.16 and 5.3 seems to be exactly the same. 

### Uninstall

Since mhwd is on life support since like 2017, you'll need to use a bit of forcing here:
```
sudo pacman -Sdd xorg-server xorg-server xorg-server-common xf86-input-libinput
sudo mhwd -r pci video-catalyst
```
