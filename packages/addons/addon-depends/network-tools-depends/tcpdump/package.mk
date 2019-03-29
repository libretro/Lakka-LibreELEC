# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="tcpdump"
PKG_VERSION="4.9.2"
PKG_SHA256="798b3536a29832ce0cbb07fafb1ce5097c95e308a6f592d14052e1ef1505fe79"
PKG_SITE="http://www.tcpdump.org/"
PKG_URL="http://www.tcpdump.org/release/tcpdump-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libpcap libtirpc"
PKG_LONGDESC="A program that allows you to dump the traffic on a network."

PKG_CONFIGURE_OPTS_TARGET="--with-crypto=no"

pre_configure_target() {
  # When cross-compiling, configure can't set linux version
  # forcing it
  sed -i -e 's/ac_cv_linux_vers=unknown/ac_cv_linux_vers=2/' ../configure
  CFLAGS+=" -I$SYSROOT_PREFIX/usr/include/tirpc"
  LDFLAGS+=" -ltirpc"
}

post_configure_target() {
  # discard native system includes
  sed -i "s%-I/usr/include%%g" Makefile
}

makeinstall_target() {
  :
}
