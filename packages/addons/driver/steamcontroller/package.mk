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

PKG_NAME="steamcontroller"
PKG_VERSION="60499dc"
PKG_REV="101"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/ynsta/steamcontroller"
PKG_URL="https://github.com/ynsta/steamcontroller/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python distutilscross:host python-libusb1 enum34 linux:host"
PKG_SECTION="driver"
PKG_SHORTDESC="A standalone userland driver for the steam controller to be used where steam client can't be installed."
PKG_LONGDESC="A standalone userland driver for the steam controller to be used where steam client can't be installed."
PKG_AUTORECONF="no"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Steam Controller Driver"
PKG_ADDON_TYPE="xbmc.service"

pre_make_target() {
  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
  export LDSHARED="$CC -shared"
}

make_target() {
  python setup.py build
}

makeinstall_target() {
  :
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -a $PKG_BUILD/build/scripts-2.7/* $ADDON_BUILD/$PKG_ADDON_ID/bin/

  mkdir	-p $ADDON_BUILD/$PKG_ADDON_ID/lib
    cp -a $PKG_BUILD/build/lib.linux-*-2.7/* $ADDON_BUILD/$PKG_ADDON_ID/lib/
    cp -a $(get_build_dir python-libusb1)/build/lib/* $ADDON_BUILD/$PKG_ADDON_ID/lib/
    cp -a $(get_build_dir enum34)/build/lib/* $ADDON_BUILD/$PKG_ADDON_ID/lib/

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/include/linux
    if [ -f "$(get_build_dir linux)/usr/include/linux/input-event-codes.h" ]; then
      cp $(get_build_dir linux)/usr/include/linux/input-event-codes.h $ADDON_BUILD/$PKG_ADDON_ID/include/linux/
    fi
    cp $(get_build_dir linux)/usr/include/linux/input.h $ADDON_BUILD/$PKG_ADDON_ID/include/linux/

  python -Wi -t -B $TOOLCHAIN/lib/python2.7/compileall.py $ADDON_BUILD/$PKG_ADDON_ID/lib/ -f 1>/dev/null
  find $ADDON_BUILD/$PKG_ADDON_ID/lib/ -name '*.py' -exec rm {} \;
}
