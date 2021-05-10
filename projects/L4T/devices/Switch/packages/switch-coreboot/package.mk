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

PKG_NAME="switch-coreboot"
PKG_VERSION="d0156146"
PKG_GIT_CLONE_BRANCH="switch-linux"
PKG_ARCH="any"
PKG_DEPENDS_HOST="gcc-linaro-aarch64-linux-gnu:host gcc-linaro-arm-linux-gnueabi:host zlib:host openssl:host"
PKG_DEPENDS_TARGET="toolchain switch-coreboot:host switch-u-boot gcc-linaro-aarch64-linux-gnu:host gcc-linaro-arm-linux-gnueabi:host curl:host"
PKG_SITE="https://gitlab.com/switchroot/switch-coreboot"
PKG_GIT_URL="$PKG_SITE"
PKG_URL="https://gitlab.com/switchroot/switch-coreboot.git"
PKG_CLEAN="switch-bootloader"
PKG_TOOLCHAIN="make"

PKG_AUTORECONF="no"

make_host() {
  export PATH=$TOOLCHAIN/lib/gcc-linaro-aarch64-linux-gnu/bin/:$PATH
  export PATH=$TOOLCHAIN/lib/gcc-linaro-arm-linux-gnueabi/bin/:$PATH
  export C_INCLUDE_PATH="$TOOLCHAIN/include:$C_INCLUDE_PATH"
  export LIBRARY_PATH="$TOOLCHAIN/lib:$LIBRARY_PATH"
  git submodule update --init --recursive
  make nintendo_switch_defconfig
  make iasl
  make tools
}

makeinstall_host() {
  :
}

pre_make_host() {
  sed -i -e "s|../switch-uboot/u-boot.elf|${BUILD}/switch-boot/u-boot.elf|" $PKG_BUILD/configs/nintendo_switch_defconfig
}

make_target() {
  export PATH=$TOOLCHAIN/lib/gcc-linaro-aarch64-linux-gnu/bin/:$PATH
  export PATH=$TOOLCHAIN/lib/gcc-linaro-arm-linux-gnueabi/bin/:$PATH
  OLD_CROSS_COMPILE=$CROSS_COMPILE
  export CROSS_COMPILE=aarch64-linux-gnu-

  # Make
  make

  export CROSS_COMPILE=$OLD_CROSS_COMPILE
}

makeinstall_target() {
  mkdir -p $BUILD/switch-boot
  cp $PKG_BUILD/build/coreboot.rom $BUILD/switch-boot
}
