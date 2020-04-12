
You can install the drivers like so:
```
./build-nvidia-304.sh
sudo pacman -Sy mhwd-nvidia-304xx
sudo mhwd -i pci video-nvidia-304xx
```

⚠️: if you use Xfce, you [need](https://bugzilla.xfce.org/show_bug.cgi?id=16367) to [switch to](https://github.com/xfce-mirror/xfwm4/blob/xfwm4-4.14.0/COMPOSITOR#L153) xpresent vblank_mode in order for composited desktop to work at all.

Other DEs couldn't be tested.
