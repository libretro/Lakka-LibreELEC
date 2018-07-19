# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="libcdio"
PKG_VERSION="0.94"
PKG_SHA256="96e2c903f866ae96f9f5b9048fa32db0921464a2286f5b586c0f02699710025a"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://www.gnu.org/software/libcdio/"
PKG_URL="http://ftpmirror.gnu.org/libcdio/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="audio"
PKG_SHORTDESC="libcdio: A CD-ROM reading and control library"
PKG_LONGDESC="This library is to encapsulate CD-ROM reading and control. Applications wishing to be oblivious of the OS- and device-dependant properties of a CD-ROM can use this library. Some support for disk image types like BIN/CUE and NRG is available, so applications that use this library also have the ability to read disc images as though they were CD's."
PKG_BUILD_FLAGS="+pic"

# package specific configure options
PKG_CONFIGURE_OPTS_TARGET="--enable-cxx \
                           --disable-cpp-progs \
                           --disable-shared \
                           --enable-static \
                           --enable-joliet \
                           --disable-rpath \
                           --enable-rock \
                           --disable-cddb \
                           --disable-vcd-info \
                           --without-cd-drive \
                           --without-cd-info \
                           --without-cdda-player \
                           --without-cd-read \
                           --without-iso-info \
                           --without-iso-read \
                           --without-libiconv-prefix \
                           --with-gnu-ld"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
