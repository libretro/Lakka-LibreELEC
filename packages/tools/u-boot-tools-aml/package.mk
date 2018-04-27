################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017-present Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="u-boot-tools-aml"
PKG_VERSION="2016.03"
PKG_SHA256="e49337262ecac44dbdeac140f2c6ebd1eba345e0162b0464172e7f05583ed7bb"
PKG_ARCH="any"
PKG_SITE="https://www.denx.de/wiki/U-Boot"
PKG_URL="ftp://ftp.denx.de/pub/u-boot/u-boot-$PKG_VERSION.tar.bz2"
PKG_SOURCE_DIR="u-boot-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain dtc:host u-boot-tools-aml:host"
PKG_LICENSE="GPL"
PKG_SECTION="tools"
PKG_SHORTDESC="u-boot: Universal Bootloader project"
PKG_LONGDESC="U-Boot bootloader utility tools. This package includes the mkimage program, which allows generation of U-Boot images in various formats, and the fw_printenv and fw_setenv programs to read and modify U-Boot's environment and other tools."

make_host() {
  make mrproper
  make dummy_defconfig
  make tools-only
}

make_target() {
  CROSS_COMPILE="$TARGET_PREFIX" LDFLAGS="" ARCH=arm make dummy_defconfig
  CROSS_COMPILE="$TARGET_PREFIX" LDFLAGS="" ARCH=arm make env
}

makeinstall_host() {
  mkdir -p $TOOLCHAIN/bin
    cp tools/mkimage $TOOLCHAIN/bin
}

makeinstall_target() {
  mkdir -p $INSTALL/etc
  cp $PKG_DIR/config/fw_env.config $INSTALL/etc/fw_env.config

  mkdir -p $INSTALL/usr/sbin
  cp tools/env/fw_printenv $INSTALL/usr/sbin/fw_printenv
  cp tools/env/fw_printenv $INSTALL/usr/sbin/fw_setenv
}
