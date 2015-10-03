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

PKG_NAME="pciutils"
PKG_VERSION="3.4.0"
PKG_REV="1"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="http://mj.ucw.cz/pciutils.shtml"
PKG_URL="http://www.kernel.org/pub/software/utils/pciutils/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain kmod systemd"
PKG_PRIORITY="optional"
PKG_SECTION="system"
PKG_SHORTDESC="pciutils: Linux PCI Utilities"
PKG_LONGDESC="This package contains various utilities for inspecting and setting of devices connected to the PCI bus and the PCI vendor/product ID database."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_MAKE_OPTS="PREFIX=/usr SHARED=no STRIP= IDSDIR=/usr/share"

make_target() {
  make OPT="$CFLAGS" \
       CROSS_COMPILE=${TARGET_PREFIX} \
       HOST=$TARGET_ARCH-linux \
       $PKG_MAKE_OPTS \
       ZLIB=no DNS=no LIBKMOD=yes HWDB=yes
}

makeinstall_target() {
  make $PKG_MAKE_OPTS DESTDIR=$SYSROOT_PREFIX install
  make $PKG_MAKE_OPTS DESTDIR=$SYSROOT_PREFIX install-lib
  make $PKG_MAKE_OPTS DESTDIR=$INSTALL install-lib
  if [ "$TARGET_ARCH" = x86_64 ]; then
    make $PKG_MAKE_OPTS DESTDIR=$INSTALL install
  fi
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/sbin/setpci
  rm -rf $INSTALL/usr/sbin/update-pciids
  rm -rf $INSTALL/usr/share
}
