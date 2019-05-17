# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mali-utgard"
PKG_VERSION="5d89e2a946c7e4dbd7e627202e7bd7c3ed49954a"
PKG_SHA256="c3e6199f58807558eb665357a35e2f86c161fc1a55f27988e604671bc27e98c7"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="https://developer.arm.com/products/software/mali-drivers/utgard-kernel"
PKG_URL="https://github.com/LibreELEC/mali-utgard/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_LONGDESC="mali-utgard: Linux drivers for Mali Utgard GPUs"
PKG_TOOLCHAIN="manual"
PKG_IS_KERNEL_PKG="yes"

case $PROJECT in
  Allwinner)
    PKG_MALI_PLATFORM="sunxi"
    ;;
  Amlogic)
    PKG_MALI_PLATFORM="meson"
    ;;
  Rockchip)
    PKG_MALI_PLATFORM="rk"
    PKG_EXTRA_CFLAGS="-DCONFIG_MALI_DT"
    PKG_CONFIGS="CONFIG_MALI_DT=y"
    ;;
esac

make_target() {
  kernel_make -C $(kernel_path) M=$PKG_BUILD/driver/src/devicedrv/mali \
    MALI_PLATFORM_FILES=platform/${PKG_MALI_PLATFORM}/${PKG_MALI_PLATFORM}.c GIT_REV="" \
    EXTRA_CFLAGS="-DMALI_FAKE_PLATFORM_DEVICE=1 -DCONFIG_MALI_DMA_BUF_MAP_ON_ATTACH -DCONFIG_MALI400=1 -DCONFIG_MALI450=1 -DCONFIG_MALI470=1 ${PKG_EXTRA_CFLAGS}" \
    CONFIG_MALI400=m CONFIG_MALI450=y CONFIG_MALI470=y CONFIG_MALI_DMA_BUF_MAP_ON_ATTACH=y ${PKG_CONFIGS}
}

makeinstall_target() {
  kernel_make -C $(kernel_path) M=$PKG_BUILD/driver/src/devicedrv/mali/ \
    INSTALL_MOD_PATH=$INSTALL/$(get_kernel_overlay_dir) INSTALL_MOD_STRIP=1 DEPMOD=: \
    modules_install
}
