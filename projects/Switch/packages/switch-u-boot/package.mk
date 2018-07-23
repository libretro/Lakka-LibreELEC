################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="switch-u-boot"
PKG_VERSION="0ee0219"
PKG_ARCH="any"
PKG_DEPENDS_TARGET="toolchain gcc-linaro-aarch64-linux-gnu:host gcc-linaro-arm-linux-gnueabi:host"
PKG_SITE="https://github.com/lakka-switch/u-boot"
PKG_GIT_URL="$PKG_SITE"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  export PATH=$TOOLCHAIN/lib/gcc-linaro-aarch64-linux-gnu/bin/:$PATH
  export PATH=$TOOLCHAIN/lib/gcc-linaro-arm-linux-gnueabi/bin/:$PATH
  OLD_CROSS_COMPILE=$CROSS_COMPILE
  export CROSS_COMPILE=aarch64-linux-gnu-
  
  make nintendo-switch_defconfig
  make
  
  export CROSS_COMPILE=$OLD_CROSS_COMPILE
}

makeinstall_target() {
  mkdir -p $BUILD/switch-boot
  cp $PKG_BUILD/u-boot.elf $BUILD/switch-boot
  
  mkdir -p $TOOLCHAIN/bin
  cp tools/mkimage $TOOLCHAIN/bin
}
