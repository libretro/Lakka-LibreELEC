# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gpu-aml"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="http://openlinux.amlogic.com:8000/download/ARM/gpu/"
PKG_VERSION="fe7a4d8"
PKG_SHA256="518f855a2b191e50d09c2d0b3e671b5ed4b5e4db06aa3a718e29ef30cc0d9a57"
PKG_URL="https://github.com/khadas/android_hardware_arm_gpu/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_LONGDESC="gpu-aml: Linux drivers for Mali GPUs found in Amlogic Meson SoCs"
PKG_TOOLCHAIN="manual"
PKG_IS_KERNEL_PKG="yes"

PKG_UTGARD_VERSION="r5p1"
PKG_UTGARD_BUILD_DIR="$PKG_BUILD/utgard/$PKG_UTGARD_VERSION"
PKG_MIDGARD_VERSION="r16p0"
PKG_MIDGARD_BUILD_DIR="$PKG_BUILD/midgard/$PKG_MIDGARD_VERSION/kernel/drivers/gpu/arm/midgard"

pre_configure_target() {
  sed -e "s|shell date|shell date -R|g" -i $PKG_BUILD/utgard/*/Kbuild
  sed -e "s|USING_GPU_UTILIZATION=1|USING_GPU_UTILIZATION=0|g" -i $PKG_BUILD/utgard/platform/Kbuild.amlogic
}

pre_make_target() {
  ln -s $PKG_BUILD/utgard/platform $PKG_UTGARD_BUILD_DIR/platform
}

make_target() {
  if [ "$MESON_FAMILY" = "gxm" ] ; then
    kernel_make -C $(kernel_path) M=$PKG_MIDGARD_BUILD_DIR \
    EXTRA_CFLAGS="-DCONFIG_MALI_PLATFORM_DEVICETREE -DCONFIG_MALI_BACKEND=gpu" \
      CONFIG_MALI_MIDGARD=m CONFIG_MALI_PLATFORM_DEVICETREE=y CONFIG_MALI_BACKEND=gpu modules
  else
    kernel_make -C $(kernel_path) M=$PKG_UTGARD_BUILD_DIR \
      EXTRA_CFLAGS="-DCONFIG_MALI450=y" \
      CONFIG_MALI400=m CONFIG_MALI450=y
  fi
}

makeinstall_target() {
  if [ "$MESON_FAMILY" = "gxm" ] ; then
    kernel_make -C $(kernel_path) M=$PKG_MIDGARD_BUILD_DIR \
      INSTALL_MOD_PATH=$INSTALL/$(get_kernel_overlay_dir) INSTALL_MOD_STRIP=1 DEPMOD=: \
    modules_install
  else
    kernel_make -C $(kernel_path) M=$PKG_UTGARD_BUILD_DIR \
      INSTALL_MOD_PATH=$INSTALL/$(get_kernel_overlay_dir) INSTALL_MOD_STRIP=1 DEPMOD=: \
    modules_install
  fi
}
