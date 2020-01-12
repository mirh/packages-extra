Manjaro legacy & special driver repo

Because if open drivers set your PC on fire, that's better than spending some time fixing the blobs /s

So.. Since mhwd (praise it) only supports whatever pacman supports, you'll have to add a custom repo to it. 
But opening notepad is annoying, so here you are with a comfy command to do this (it's only needed once)
`sudo sh -c "echo -e '[legacyhw]\nSigLevel = Optional TrustAll\nServer = file://$HOME/packages' >> /etc/pacman.conf"`

Now, you can just download the repo and run one of the many build scripts there are in the root 
(ok, truth be told I only had time to fix nvidia304xx for the moment.. the remainder will come hopefully)

Once that has finished, you can just install the drivers like so:
```
sudo pacman -Sy mhwd-nvidia-304xx
sudo mhwd -i pci video-nvidia-304xx
```
