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

PKG_NAME="gpu-sunxi"
PKG_VERSION="r6p2-01rel0"
PKG_SHA256="bb49d23ab3d9fbeb701a127e6f28cff1c963bba05786f98d76edff1df0fe6c52"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="https://developer.arm.com/products/software/mali-drivers/utgard-kernel"
PKG_URL="https://developer.arm.com/-/media/Files/downloads/mali-drivers/kernel/mali-utgard-gpu/DX910-SW-99002-$PKG_VERSION.tgz"
PKG_SOURCE_DIR="DX910-SW-99002-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="driver"
PKG_SHORTDESC="gpu-sunxi: Linux drivers for Mali GPUs found in Allwinner SoCs"
PKG_LONGDESC="gpu-sunxi: Linux drivers for Mali GPUs found in Allwinner SoCs"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
PKG_IS_KERNEL_PKG="yes"

DRIVER_DIR=$PKG_BUILD/src/devicedrv/mali/

pre_patch() {
  # move source dir to allow patching
  mv $PKG_BUILD/driver/src $PKG_BUILD/
  rm -rf $PKG_BUILD/driver
}

make_target() {
  USING_UMP=0 \
  BUILD=$BUILD \
  USING_PROFILING=0 \
  MALI_PLATFORM=sunxi \
  USING_DVFS=1 \
  USING_DEVFREQ=0 \
  KDIR=$(kernel_path) \
  CROSS_COMPILE=$TARGET_PREFIX \
    make -C $DRIVER_DIR
}

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_module_dir)/$PKG_NAME
    cp $DRIVER_DIR/*.ko $INSTALL/$(get_full_module_dir)/$PKG_NAME
}
