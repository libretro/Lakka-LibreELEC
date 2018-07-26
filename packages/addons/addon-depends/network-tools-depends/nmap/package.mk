# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="nmap"
PKG_VERSION="7.70"
PKG_SHA256="847b068955f792f4cc247593aca6dc3dc4aae12976169873247488de147a6e18"
PKG_LICENSE="GPL"
PKG_SITE="http://nmap.org/"
PKG_URL="http://nmap.org/dist/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain openssl"
PKG_LONGDESC="Free Security Scanned for Network."

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

makeinstall_target() {
  :
}
