## Manjaro legacy & special driver repo

Because if open drivers set your PC on fire, that'd be better than spending some time fixing the blobs /s

So.. Since mhwd (praise it) only supports whatever pacman supports, you are gonna need to add it a custom repo. 
But opening notepads is annoying, so here you are with a comfy command to do this (only use it once):

`sudo sh -c "echo -e '[legacyhw]\nSigLevel = Optional TrustAll\nServer = file://$HOME/packages' >> /etc/pacman.conf"`

Now, just [download](https://github.com/mirh/packages-legacy/archive/master.zip) this repository and follow the instructions inside your folder of interest. 
Please read them, it's not nice to reboot to a black screen.
