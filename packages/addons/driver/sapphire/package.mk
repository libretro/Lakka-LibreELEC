################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="sapphire"
PKG_VERSION="6.6"
PKG_REV="102"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="https://libreelec.tv"
PKG_URL="http://www.rtr.ca/sapphire_remote/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux bash"
PKG_SECTION="driver.remote"
PKG_SHORTDESC="A Linux driver to add support for sapphire remotes"
PKG_LONGDESC="A Linux driver to add support for sapphire remotes"
PKG_AUTORECONF="no"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Sapphire Remote Driver"
PKG_ADDON_TYPE="xbmc.service"

if [ -f $SYSROOT_PREFIX/usr/include/linux/input-event-codes.h ]; then
  INPUT_H="$SYSROOT_PREFIX/usr/include/linux/input-event-codes.h"
else
  INPUT_H="$SYSROOT_PREFIX/usr/include/linux/input.h"
fi

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  make V=1 \
       KVER=$(kernel_version) \
       KDIR=$(kernel_path) \
       INPUT_H=$INPUT_H
}

post_make_target() {
  sed -i -e 's|modprobe sapphire|insmod /storage/.kodi/addons/driver.remote.sapphire/lib/sapphire.ko|' \
         -e 's|/etc/sapphire.keymap|/storage/.kodi/userdata/addon_data/driver.remote.sapphire/sapphire.keymap|' \
         -e 's|/usr/local/bin/sapphire_keymap.sh|/storage/.kodi/addons/driver.remote.sapphire/bin/sapphire_keymap.sh|' \
         -e 's|\&\& /usr/local/bin/sapphire_keymap.sh|\&\& /storage/.kodi/addons/driver.remote.sapphire/bin/sapphire_keymap.sh /storage/.kodi/userdata/addon_data/driver.remote.sapphire/sapphire.keymap|' \
         sapphire_startup.sh

  sed -i -e 's|\#\!/bin/bash|\#\!/storage/.kodi/addons/driver.remote.sapphire/bin/bash|' \
         sapphire_startup.sh sapphire_keymap.sh
}

makeinstall_target() {
  :
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/lib/
    cp $PKG_BUILD/*.ko $ADDON_BUILD/$PKG_ADDON_ID/lib

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/etc
    cp $PKG_BUILD/keymap.default $ADDON_BUILD/$PKG_ADDON_ID/etc

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin/
    cp $PKG_BUILD/sapphire_startup.sh $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp $PKG_BUILD/sapphire_keymap.sh $ADDON_BUILD/$PKG_ADDON_ID/bin

  # bash
    cp $(get_build_dir bash)/.install_pkg/usr/bin/bash $ADDON_BUILD/$PKG_ADDON_ID/bin
}
