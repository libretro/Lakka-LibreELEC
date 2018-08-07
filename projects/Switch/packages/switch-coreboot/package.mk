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
PKG_VERSION="1becafe"
PKG_ARCH="any"
PKG_DEPENDS_TARGET="toolchain switch-coreboot:host switch-u-boot gcc-linaro-aarch64-linux-gnu:host gcc-linaro-arm-linux-gnueabi:host"
PKG_SITE="https://github.com/lakka-switch/coreboot"
PKG_GIT_URL="$PKG_SITE"

PKG_AUTORECONF="no"

make_host() {
  make nintendo_switch_defconfig
  make iasl
  make tools
}

makeinstall_host() {
  :
}

pre_make_host() {
  sed -i -e "s|CONFIG_PAYLOAD_FILE=\"../u-boot/u-boot.elf\"|CONFIG_PAYLOAD_FILE=\"${BUILD}/switch-boot/u-boot.elf\"|" $PKG_BUILD/configs/nintendo_switch_defconfig
  sed -i -e "s|CONFIG_MTC_TABLES_DIRECTORY=\"../shofel2/mtc_tables\"|CONFIG_MTC_TABLES_DIRECTORY=\"${PKG_DIR}/mtc\"|" $PKG_BUILD/configs/nintendo_switch_defconfig
}

make_target() {
  export PATH=$TOOLCHAIN/lib/gcc-linaro-aarch64-linux-gnu/bin/:$PATH
  export PATH=$TOOLCHAIN/lib/gcc-linaro-arm-linux-gnueabi/bin/:$PATH
  OLD_CROSS_COMPILE=$CROSS_COMPILE
  export CROSS_COMPILE=aarch64-linux-gnu-
  
  # Download and copy tegra_mtc.bin to $PKG_BUILD/src/soc/nvidia/tegra210/tegra_mtc.bin (by vgmoose)
  mkdir -p $PKG_BUILD/switch-mtc
  
  # Download the needed parts of the factory image zip
  curl --header "Range: bytes=1842-3820027" -k https://dl.google.com/dl/android/aosp/ryu-opm4.171019.021.n1-factory-1f31fdce.zip > $PKG_BUILD/switch-mtc/tmp.zip
  
  # Extract the bootloader zip from the factory image zip
  echo y | zip -FF $PKG_BUILD/switch-mtc/tmp.zip --out $PKG_BUILD/switch-mtc/out.zip
  
  # Extract the bootloader image file from the bootloader zip
  unzip $PKG_BUILD/switch-mtc/out.zip -d $PKG_BUILD/switch-mtc
  
  # Extract the mtc from the bootloader image file
  $PKG_BUILD/build/util/cbfstool/cbfstool $PKG_BUILD/switch-mtc/ryu-opm4.171019.021.n1/bootloader-dragon-google_smaug.7900.126.0.img extract -n fallback/tegra_mtc -f $PKG_BUILD/src/soc/nvidia/tegra210/tegra_mtc.bin
  
  # Make
  make
  
  export CROSS_COMPILE=$OLD_CROSS_COMPILE
}

makeinstall_target() {
  mkdir -p $BUILD/switch-boot
  cp $PKG_BUILD/build/coreboot.rom $BUILD/switch-boot
}
