# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mali-bifrost"
PKG_VERSION="c56ef20e65d361a1964e3b86c03afad1f56491ae" # BX301A01B-SW-99002-r16p0-01rel0_meson-g12b
PKG_SHA256="8ba6db7448ea175c06c3f6d50ab5d35180dd7467fcc8ec6d2b4636bcad28531b"
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
