# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gpu-sunxi-midgard"
PKG_VERSION="r22p0-01rel0"
PKG_SHA256="02f80e777dc945d645fce888afc926555ec61b70079c1da289bf1a3a9544452f"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="https://developer.arm.com/products/software/mali-drivers/"
PKG_URL="https://developer.arm.com/-/media/Files/downloads/mali-drivers/kernel/mali-midgard-gpu/TX011-SW-99002-$PKG_VERSION.tgz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_LONGDESC="gpu-sunxi-midgard: Linux drivers for Mali GPUs found in Allwinner SoCs"
PKG_TOOLCHAIN="manual"
PKG_IS_KERNEL_PKG="yes"

make_target() {
  kernel_make -C $(kernel_path) M=$PKG_BUILD/driver/product/kernel/drivers/gpu/arm/midgard/ \
    EXTRA_CFLAGS="-DCONFIG_MALI_PLATFORM_DEVICETREE -DCONFIG_MALI_BACKEND=gpu -DCONFIG_MALI_DEVFREQ" CONFIG_MALI_DEVFREQ=y \
    CONFIG_MALI_MIDGARD=m CONFIG_MALI_PLATFORM_DEVICETREE=y CONFIG_MALI_BACKEND=gpu modules
}

makeinstall_target() {
  kernel_make -C $(kernel_path) M=$PKG_BUILD/driver/product/kernel/drivers/gpu/arm/midgard/ \
    INSTALL_MOD_PATH=$INSTALL/$(get_kernel_overlay_dir) INSTALL_MOD_STRIP=1 DEPMOD=: \
    modules_install
}
