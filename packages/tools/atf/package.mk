# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC

PKG_NAME="atf"
PKG_VERSION="v2.2"
PKG_SHA256="07e3c058ae2d95c7d516a46fc93565b797e912c3271ddbf29df523b1ab1ee911"
PKG_ARCH="arm aarch64"
PKG_LICENSE="BSD-3c"
PKG_SITE="https://github.com/ARM-software/arm-trusted-firmware"
PKG_URL="https://github.com/ARM-software/arm-trusted-firmware/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ARM Trusted Firmware is a reference implementation of secure world software, including a Secure Monitor executing at Exception Level 3 and various Arm interface standards."
PKG_TOOLCHAIN="manual"

[ -n "$KERNEL_TOOLCHAIN" ] && PKG_DEPENDS_TARGET+=" gcc-arm-$KERNEL_TOOLCHAIN:host"

make_target() {
  CROSS_COMPILE="$TARGET_KERNEL_PREFIX" LDFLAGS="" CFLAGS="" make PLAT=$ATF_PLATFORM bl31
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/bootloader
  cp -a build/$ATF_PLATFORM/release/bl31.bin $INSTALL/usr/share/bootloader
}
