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

#switch-coreboot:host must be built before switch-coreboot

PKG_NAME="switch-coreboot"
PKG_VERSION="1becafe"
PKG_ARCH="any"
PKG_DEPENDS_TARGET="toolchain switch-u-boot gcc-linaro-aarch64-linux-gnu:host gcc-linaro-arm-linux-gnueabi:host"
PKG_SITE="https://github.com/lakka-switch/coreboot"
PKG_GIT_URL="$PKG_SITE"

make_host() {
  make iasl
}

makeinstall_host() {
  :
}

pre_make_target() {
  if [ -e "$PKG_DIR/mtc/tegra_mtc.bin" ]; then
    cp $PKG_DIR/mtc/tegra_mtc.bin $PKG_BUILD/src/soc/nvidia/tegra210/tegra_mtc.bin
  else
    echo "Please put tegra_mtc.bin in $PKG_DIR/mtc and try again"
    exit 1
  fi
  
  sed -i -e "s|CONFIG_PAYLOAD_FILE=\"../u-boot/u-boot.elf\"|CONFIG_PAYLOAD_FILE=\"${BUILD}/switch-boot/u-boot.elf\"|" $PKG_BUILD/configs/nintendo_switch_defconfig
  sed -i -e "s|CONFIG_MTC_TABLES_DIRECTORY=\"../shofel2/mtc_tables\"|CONFIG_MTC_TABLES_DIRECTORY=\"${PKG_DIR}/mtc\"|" $PKG_BUILD/configs/nintendo_switch_defconfig
}

make_target() {
  export PATH=$TOOLCHAIN/lib/gcc-linaro-aarch64-linux-gnu/bin/:$PATH
  export PATH=$TOOLCHAIN/lib/gcc-linaro-arm-linux-gnueabi/bin/:$PATH
  OLD_CROSS_COMPILE=$CROSS_COMPILE
  export CROSS_COMPILE=aarch64-linux-gnu-
  
  make nintendo_switch_defconfig
  make
  
  export CROSS_COMPILE=$OLD_CROSS_COMPILE
}

makeinstall_target() {
  mkdir -p $BUILD/switch-boot
  cp $PKG_BUILD/build/coreboot.rom $BUILD/switch-boot
}
