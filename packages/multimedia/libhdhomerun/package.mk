# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libhdhomerun"
PKG_VERSION="7c54382fb681d03888b469033e50bebaf4ce6bce" # Release 20201023
PKG_SHA256="d686f88b8dc6089e2cb3829958170d6ba02ecc4f2c5f2cfe3fd37e0dda76ce42"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.silicondust.com"
PKG_URL="https://github.com/Silicondust/libhdhomerun/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="The library provides functionality to setup the HDHomeRun."

PKG_MAKE_OPTS_TARGET="CROSS_COMPILE=${TARGET_PREFIX}"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp -PR hdhomerun_config ${INSTALL}/usr/bin

  mkdir -p ${INSTALL}/usr/lib/
    cp -PR libhdhomerun.so ${INSTALL}/usr/lib/

  mkdir -p ${SYSROOT_PREFIX}/usr/include/hdhomerun
    cp *.h ${SYSROOT_PREFIX}/usr/include/hdhomerun

  mkdir -p ${SYSROOT_PREFIX}/usr/lib
    cp libhdhomerun.so ${SYSROOT_PREFIX}/usr/lib
}
