# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="pciutils"
PKG_VERSION="3.5.4"
PKG_SHA256="64293c6ab9318c40ef262b76d87bd9097531759752bac556e50979b1e63cfe66"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="http://mj.ucw.cz/pciutils.shtml"
PKG_URL="http://www.kernel.org/pub/software/utils/pciutils/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain kmod systemd"
PKG_LONGDESC="Utilities for inspecting devices connected to the PCI bus and the PCI vendor/product ID database."

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
