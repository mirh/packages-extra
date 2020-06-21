#!/bin/bash
# Remember sudo has stupid timeouts
# And upstream is obnoxious (FS#65134)
_KERN=`cat /usr/lib/modules/*/pkgbase`
_ROOT=`dirname "$(realpath "$0")"`
_PKG=""
set -e

rm -rf ~/packages/*.pkg.tar.xz
mkdir -p ~/packages
# gcc 10 has this broken
cd "${_ROOT}"/xorg-server1.12
PKGDEST=~/packages makepkg -Cfs
if ! pacman -Q xorg-server1.12-devel > /dev/null 2>&1; then
    sudo pacman -U ~/packages/xorg-server1.12-devel*.pkg*
fi
cd ../xf86-input-evdev1.12
PKGDEST=~/packages makepkg -f
cd ../catalyst-legacy-utils
PKGDEST=~/packages makepkg -fC
cd ..

for k in 44; do
  if (pacman -Q linux$k-headers > /dev/null 2>&1); then
    cd "${_ROOT}"/linux$k-extramodules
    SRCDEST="${_ROOT}"/catalyst-legacy-utils PKGDEST=~/packages makepkg -fC
    _KERN=${_KERN//linux$k/}
  else
    echo "You are missing the headers for linux$k. It won't be built."
    echo "If it's not a kernel you have installed, you shouldn't worry too much."
  fi
done
if [[ ! -z "${_KERN//$'\n'}" ]]; then
  echo "Installed kernels $_KERN didn't have any module built."
  echo "It's not my business how you are going to handle that, but mhwd definitively won't like it."
fi

# echo ${_PKG[*]}
if grep -qw legacyhw /etc/pacman.conf; then
  repo-add ~/packages/legacyhw.db.tar.bz2 ~/packages/*.pkg.tar.xz
else
  echo "Don't forget to add the custom repository to your pacman.conf"
  echo 'Then run: repo-add ~/packages/legacyhw.db.tar.bz2 ~/packages/*.pkg.tar.xz'
fi
