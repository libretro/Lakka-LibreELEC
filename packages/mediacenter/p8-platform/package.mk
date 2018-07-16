# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="p8-platform"
PKG_VERSION="3219004"
PKG_SHA256="5225417c2c174d49124d0e44d32e3828f9b83464422445d303adb2dc3111686d"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kodi.tv"
PKG_URL="https://github.com/Pulse-Eight/platform/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="platform-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="multimedia"
PKG_SHORTDESC="Platform support library used by libCEC and binary add-ons for Kodi"
PKG_LONGDESC="Platform support library used by libCEC and binary add-ons for Kodi"

PKG_CMAKE_OPTS_TARGET="-DCMAKE_INSTALL_LIBDIR:STRING=lib \
                       -DCMAKE_INSTALL_LIBDIR_NOARCH:STRING=lib \
                       -DCMAKE_INSTALL_PREFIX_TOOLCHAIN=$SYSROOT_PREFIX/usr \
                       -DBUILD_SHARED_LIBS=0"

post_makeinstall_target() {
  rm -rf $INSTALL/usr
}
