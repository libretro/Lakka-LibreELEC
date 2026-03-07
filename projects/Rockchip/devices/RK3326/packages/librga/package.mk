# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present ROCKNIX (https://github.com/ROCKNIX)

PKG_NAME="librga"
PKG_VERSION="ccfec13d6c48e3f0c7f24810b3dac162c40cdda8"
PKG_ARCH="arm aarch64"
PKG_LICENSE="Apache-2.0"
PKG_DEPENDS_TARGET="toolchain libdrm"
PKG_SITE="https://github.com/varphone/rockchip-linux-rga"
PKG_URL="${PKG_SITE}.git"
PKG_LONGDESC="RGA is an independent 2D hardware acceleration userspace driver"
PKG_TOOLCHAIN="meson"

post_makeinstall_target() {
  wget https://github.com/davidgfnet/linux-rga/raw/refs/heads/master/RockchipRgaMacro.h
    cp -av ./RockchipRgaMacro.h "${SYSROOT_PREFIX}/usr/include/rga"
}
