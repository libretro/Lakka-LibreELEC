# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wayland"
PKG_VERSION="1.14.0"
PKG_SHA256="ed80cabc0961a759a42092e2c39aabfc1ec9a13c86c98bbe2b812f008da27ab8"
PKG_LICENSE="OSS"
PKG_SITE="https://wayland.freedesktop.org/"
PKG_URL="https://wayland.freedesktop.org/releases/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain wayland:host libxml2"
PKG_DEPENDS_HOST="libffi:host expat:host libxml2:host"
PKG_LONGDESC="a display server protocol"

PKG_CONFIGURE_OPTS_HOST="--enable-shared \
                         --disable-static \
                         --disable-libraries \
                         --disable-documentation \
                         --with-gnu-ld"

PKG_CONFIGURE_OPTS_TARGET="--with-sysroot=$SYSROOT_PREFIX \
                           --with-host-scanner \
                           --enable-shared \
                           --disable-static \
                           --enable-libraries \
                           --disable-documentation \
                           --with-gnu-ld"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
  rm -rf $INSTALL/usr/share

  cp $TOOLCHAIN/lib/pkgconfig/wayland-scanner.pc $SYSROOT_PREFIX/usr/lib/pkgconfig/
}
