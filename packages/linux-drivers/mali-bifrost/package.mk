# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mali-bifrost"
PKG_VERSION="79755036ecadecff0963cb55537d361708618122" # BX301A01B-SW-99002-r16p0-01rel0_meson-g12b
PKG_SHA256="f3d7ea0cc3a0fc215274c19ca3068f0ca0094206663497147906cde8f3671232"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="https://developer.arm.com/products/software/mali-drivers/bifrost-kernel"
PKG_URL="https://github.com/LibreELEC/mali-bifrost/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_LONGDESC="mali-midgard: the Linux kernel driver for ARM Mali Midgard GPUs"
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
