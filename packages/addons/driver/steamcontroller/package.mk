# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="steamcontroller"
PKG_VERSION="60499dc"
PKG_SHA256="04a846c6f659fb5efca7747fe78e15c1348b5e0579437bb425f538318289bb80"
PKG_REV="102"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/ynsta/steamcontroller"
PKG_URL="https://github.com/ynsta/steamcontroller/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python2 distutilscross:host python-libusb1 enum34 linux:host"
PKG_SECTION="driver"
PKG_SHORTDESC="A standalone userland driver for the steam controller to be used where steam client can't be installed."
PKG_LONGDESC="A standalone userland driver for the steam controller to be used where steam client can't be installed."
PKG_TOOLCHAIN="manual"

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

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -a $PKG_BUILD/build/scripts-2.7/* $ADDON_BUILD/$PKG_ADDON_ID/bin/

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/lib
    cp -a $PKG_BUILD/build/lib.linux-*-2.7/* $ADDON_BUILD/$PKG_ADDON_ID/lib/
    cp -a $(get_build_dir python-libusb1)/build/lib/* $ADDON_BUILD/$PKG_ADDON_ID/lib/
    cp -a $(get_build_dir enum34)/build/lib/* $ADDON_BUILD/$PKG_ADDON_ID/lib/

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/include/linux
    if [ -f "$(get_build_dir linux)/usr/include/linux/input-event-codes.h" ]; then
      cp $(get_build_dir linux)/usr/include/linux/input-event-codes.h $ADDON_BUILD/$PKG_ADDON_ID/include/linux/
    fi
    cp $(get_build_dir linux)/usr/include/linux/input.h $ADDON_BUILD/$PKG_ADDON_ID/include/linux/

  $TOOLCHAIN/bin/python -Wi -t -B $TOOLCHAIN/lib/$PKG_PYTHON_VERSION/compileall.py $ADDON_BUILD/$PKG_ADDON_ID/lib/ -f 1>/dev/null
  find $ADDON_BUILD/$PKG_ADDON_ID/lib/ -name '*.py' -exec rm {} \;
}
