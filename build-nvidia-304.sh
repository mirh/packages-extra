#!/bin/bash
# TODO: somehow handle sudo's stupid passwd_timeout
_KERN="316 318 414 419 52 54"
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
cd ..
# for f in `realpath nvidia*304*/*nv*pkg.tar*`; do _PKG+=(${f}) ; done

# rm -Rf */*nvidia*304*/{src,pkg}
for k in ${_KERN[@]}; do
  if (pacman -Q linux$k-headers > /dev/null 2>&1); then
    cd "${_ROOT}"/linux$k-extramodules/nvidia-304xx
    SRCDEST="${_ROOT}"/nvidia-304xx-utils PKGDEST=~/packages makepkg -dfC
    #_PKG+=`realpath linux*nvidia*pkg.tar*`
  fi
done

# echo ${_PKG[*]}
if grep -qw legacyhw /etc/pacman.conf; then
  repo-add ~/packages/legacyhw.db.tar.bz2 ~/packages/*.pkg.tar.xz
else
  echo "Don't forget to add the custom repository to your pacman.conf"
  echo 'Then run repo-add ~/packages/legacyhw.db.tar.bz2 ~/packages/*.pkg.tar.xz'
fi