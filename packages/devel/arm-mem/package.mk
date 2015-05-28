################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="arm-mem"
PKG_VERSION="4418bb4"
PKG_REV="1"
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/bavison/arm-mem"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_DEPENDS_INIT="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="devel"
PKG_SHORTDESC="arm-mem: ARM-accelerated versions of selected functions from string.h"
PKG_LONGDESC="arm-mem is a ARM-accelerated versions of selected functions from string.h"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [  "$TARGET_CPU" = "arm1176jzf-s" ]; then
  ARMMEM_SO=libarmmem.so
elif [  "$TARGET_CPU" = "cortex-a7" ]; then
  ARMMEM_SO=libarmmem-a7.so
fi

PKG_MAKE_OPTS_TARGET="$ARMMEM_SO"

pre_make_target() {
  export CROSS_COMPILE=$TARGET_PREFIX
}

make_init() {
  : # reuse make_target()
}

makeinstall_target() {
  mkdir -p $INSTALL/lib
    cp -P $ARMMEM_SO $INSTALL/lib

  mkdir -p $INSTALL/etc
    echo "/lib/$ARMMEM_SO" >> $INSTALL/etc/ld.so.preload
}

makeinstall_init() {
  mkdir -p $INSTALL/lib
    cp -P $ARMMEM_SO $INSTALL/lib

  mkdir -p $INSTALL/etc
    echo "/lib/$ARMMEM_SO" >> $INSTALL/etc/ld.so.preload
}

