################################################################################
#      This file is part of LibreELEC - https://LibreELEC.tv
#      Copyright (C) 2016 Team LibreELEC
#      Copyright (C) 2016 kszaq
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

PKG_NAME="mt7601u-aml"
PKG_REV="1"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="http://openlinux.amlogic.com:8000/download/ARM/wifi/"
PKG_VERSION="4e61a61"
PKG_URL="https://github.com/khadas/android_hardware_wifi_mtk_drivers_mt7601/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="android_hardware_wifi_mtk_drivers_mt7601-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="driver"
PKG_SHORTDESC="mt7601u-aml"
PKG_LONGDESC="mt7601u-aml"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$TARGET_KERNEL_ARCH" = "arm64" -a "$TARGET_ARCH" = "arm" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET gcc-linaro-aarch64-linux-gnu:host"
  export PATH=$TOOLCHAIN/lib/gcc-linaro-aarch64-linux-gnu/bin/:$PATH
  TARGET_PREFIX=aarch64-linux-gnu-
fi

make_target() {
  LDFLAGS="" make -C $(kernel_path) M=$PKG_BUILD ARCH=$TARGET_KERNEL_ARCH CROSS_COMPILE=$TARGET_PREFIX
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/modules/$(get_module_dir)/$PKG_NAME
  cp $PKG_BUILD/mtprealloc.ko $INSTALL/usr/lib/modules/$(get_module_dir)/$PKG_NAME
  cp $PKG_BUILD/mt7601usta.ko $INSTALL/usr/lib/modules/$(get_module_dir)/$PKG_NAME

  mkdir -p $INSTALL/usr/lib/firmware
  cp $PKG_BUILD/RT2870STA_7601.dat $INSTALL/usr/lib/firmware
}
