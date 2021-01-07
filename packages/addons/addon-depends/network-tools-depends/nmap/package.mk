# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="nmap"
PKG_VERSION="7.91"
PKG_SHA256="18cc4b5070511c51eb243cdd2b0b30ff9b2c4dc4544c6312f75ce3a67a593300"
PKG_LICENSE="GPL"
PKG_SITE="http://nmap.org/"
PKG_URL="http://nmap.org/dist/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain openssl"
PKG_LONGDESC="Free Security Scanned for Network."
PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --with-pcap=linux \
                           --with-libpcap=included \
                           --with-libpcre=included \
                           --with-libdnet=included \
                           --with-liblua=included \
                           --with-liblinear=included \
                           --with-openssl=$SYSROOT_PREFIX"

pre_configure_target() {
# nmap fails to build in subdirs
  cd $PKG_BUILD
    rm -rf .$TARGET_NAME

  export CPPFLAGS="$CPPFLAGS -Iliblua"
}
