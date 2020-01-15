## Manjaro legacy & special driver repo

Because if open drivers set your PC on fire, that's better than spending some time fixing the blobs /s

So.. Since mhwd (praise it) only supports whatever pacman supports, you are gonna need to add it a custom repo. 
But opening notepads is annoying, so here you are with a comfy command to do this (only use it once):

`sudo sh -c "echo -e '[legacyhw]\nSigLevel = Optional TrustAll\nServer = file://$HOME/packages' >> /etc/pacman.conf"`

---
Now, you can just download this repository and run one of the many build scripts there are in the root 
(ok, truth be told I only had time to fix nvidia304xx for the moment.. the remainder will come hopefully)

Once that has finished, you can just install the drivers like so:
```
sudo pacman -Sy mhwd-nvidia-304xx
sudo mhwd -i pci video-nvidia-304xx
```
⚠️: if you use Xfce, you [need](https://bugzilla.xfce.org/show_bug.cgi?id=16367) to [switch to](https://github.com/xfce-mirror/xfwm4/blob/xfwm4-4.14.0/COMPOSITOR#L153) xpresent vblank_mode in order for composited desktop to work at all. 
