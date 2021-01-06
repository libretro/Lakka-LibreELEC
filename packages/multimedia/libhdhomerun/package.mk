# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libhdhomerun"
PKG_VERSION="64aa1606b58e9654385333031c5d7bf02989bf49" #20200303
PKG_SHA256="bd2601ccbf78a15310f28e2b4384477fb124490688dd4177f8bb9e689d0b2fd8"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.silicondust.com"
PKG_URL="https://github.com/Silicondust/libhdhomerun/archive/${PKG_VERSION}.tar.gz"
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
