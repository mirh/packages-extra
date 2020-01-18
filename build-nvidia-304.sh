#!/bin/bash
# Remember sudo has stupid timeouts
# And upstream is obnoxious (FS#65134)
_KERN=`cat /usr/lib/modules/*/pkgbase` # or you could use&filter mhwd -li I guess?
_ROOT=`dirname "$(realpath "$0")"`
_PKG=""
set -e

rm -rf ~/packages/*.pkg.tar.xz
mkdir -p ~/packages
cd "${_ROOT}"/xorg119/xorg-server
makepkg -s
cd ../../nvidia304-server
SRCDEST=../xorg119/xorg-server PKGDEST=~/packages makepkg -sf
cd ../nvidia304-video
PKGDEST=~/packages makepkg -df
cd ../nvidia-304xx-utils
PKGDEST=~/packages makepkg -dfC
cd ../lib32-nvidia-304xx-utils
SRCDEST=../nvidia-304xx-utils PKGDEST=~/packages makepkg -dfC
cd ..
# for f in `realpath nvidia*304*/*nv*pkg.tar*`; do _PKG+=(${f}) ; done

# rm -Rf */*nvidia*304*/{src,pkg}
for k in "316 318 414 419 54"; do
  if (pacman -Q linux$k-headers > /dev/null 2>&1); then
    cd "${_ROOT}"/linux$k-extramodules/nvidia-304xx
    SRCDEST="${_ROOT}"/nvidia-304xx-utils PKGDEST=~/packages makepkg -dfC
    _KERN=${_KERN//linux$k/}
    #_PKG+=`realpath linux*nvidia*pkg.tar*`
  else
    echo "You are missing the headers for linux$k. It won't be built."
	echo "If it's not a kernel you have installed, you shouldn't worry too much."
  fi
done
if [[ -z "${_KERN// }" ]]; then 
  echo "Installed kernels $_KERN didn't have any module built." 
  echo "It's not my business how you are going to handle that, but mhwd definitively won't like it."
done

# echo ${_PKG[*]}
if grep -qw legacyhw /etc/pacman.conf; then
  repo-add ~/packages/legacyhw.db.tar.bz2 ~/packages/*.pkg.tar.xz
else
  echo "Don't forget to add the custom repository to your pacman.conf"
  echo 'Then run: repo-add ~/packages/legacyhw.db.tar.bz2 ~/packages/*.pkg.tar.xz'
fi