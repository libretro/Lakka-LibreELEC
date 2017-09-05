################################################################################
#      This file is part of LibreELEC - https://LibreELEC.tv
#      Copyright (C) 2016 Team LibreELEC
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

PKG_NAME="brcmap6xxx-aml"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="http://openlinux.amlogic.com:8000/download/ARM/wifi/"
PKG_VERSION="de3f5c5"
PKG_URL="https://github.com/openwetek/brcmap6xxx-aml/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux wlan-firmware-aml"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="driver"
PKG_SHORTDESC="brcmap6xxx-aml: Linux drivers for AP6xxx WLAN chips used in some devices based on Amlogic SoCs"
PKG_LONGDESC="brcmap6xxx-aml: Linux drivers for AP6xxx WLAN chips used in some devices based on Amlogic SoCs"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ $TARGET_KERNEL_ARCH = "arm64" ] && [ $TARGET_ARCH == "arm"  ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET gcc-linaro-aarch64-elf:host"
  export PATH=$TOOLCHAIN/lib/gcc-linaro-aarch64-elf/bin/:$PATH
  TARGET_PREFIX=aarch64-elf-
fi

make_target() {
  cd bcmdhd_1_201_59_x
  LDFLAGS="" make V=1 \
    -C $(kernel_path) M=$PKG_BUILD/bcmdhd_1_201_59_x \
    ARCH=$TARGET_KERNEL_ARCH \
    CROSS_COMPILE=$TARGET_PREFIX
}

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_module_dir)/bcmdhd
  cp *.ko $INSTALL/$(get_full_module_dir)/bcmdhd

  mkdir -p $INSTALL/usr/lib/firmware/brcm
  cp $PKG_DIR/config/config.txt $INSTALL/usr/lib/firmware/brcm
}
