# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mali-bifrost"
PKG_VERSION="61bf5319dfd266b72a96c9c2d518dbbde8514d66" # BX301A01B-SW-99002-r16p0-01rel0
PKG_SHA256="b21d840586f24638d76d5a9684b812a4cb9415006f320a34db6f8b389cfb0a1c"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="https://developer.arm.com/products/software/mali-drivers/bifrost-kernel"
PKG_URL="https://github.com/LibreELEC/mali-bifrost/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_LONGDESC="mali-bifrost: the Linux kernel driver for ARM Mali Bifrost GPUs"
PKG_TOOLCHAIN="manual"
PKG_IS_KERNEL_PKG="yes"

case $PROJECT in
  Amlogic)
    PKG_MALI_PLATFORM_CONFIG="config.meson-g12a"
    ;;
esac

make_target() {
  kernel_make KDIR=$(kernel_path) -C $PKG_BUILD \
       CONFIG_NAME=$PKG_MALI_PLATFORM_CONFIG
}

makeinstall_target() {
  DRIVER_DIR=$PKG_BUILD/driver/product/kernel/drivers/gpu/arm/midgard/

  mkdir -p $INSTALL/$(get_full_module_dir)/$PKG_NAME
    cp $DRIVER_DIR/mali_kbase.ko $INSTALL/$(get_full_module_dir)/$PKG_NAME/
}
