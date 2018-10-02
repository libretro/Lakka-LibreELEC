# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libhdhomerun"
PKG_VERSION="20180817"
PKG_SHA256="437888b27206f526827ee7a4c57c1c167a36483b0445232e07fb7bb7ee854b42"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.silicondust.com"
PKG_URL="http://download.silicondust.com/hdhomerun/${PKG_NAME}_${PKG_VERSION}.tgz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="The library provides functionality to setup the HDHomeRun."

PKG_MAKE_OPTS_TARGET="CROSS_COMPILE=$TARGET_PREFIX"

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp -PR hdhomerun_config $INSTALL/usr/bin

  mkdir -p $INSTALL/usr/lib/
    cp -PR libhdhomerun.so $INSTALL/usr/lib/

  mkdir -p $SYSROOT_PREFIX/usr/include/hdhomerun
    cp *.h $SYSROOT_PREFIX/usr/include/hdhomerun

  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp libhdhomerun.so $SYSROOT_PREFIX/usr/lib
}
