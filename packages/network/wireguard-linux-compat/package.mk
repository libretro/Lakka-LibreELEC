# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wireguard-linux-compat"
PKG_VERSION="v0.0.20200215"
PKG_SHA256="0ae4d63e93e94a8953209c547416d84470816d152cdb8df4f36f3169cf3f43a6"
PKG_LICENSE="GPLv2"
PKG_SITE="https://www.wireguard.com"
PKG_URL="https://git.zx2c4.com/wireguard-linux-compat/snapshot/wireguard-linux-compat-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain linux libmnl"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_LONGDESC="WireGuard VPN kernel module"
PKG_TOOLCHAIN="manual"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  kernel_make KERNELDIR=$(kernel_path) -C src/ module
}

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_module_dir)/$PKG_NAME
    cp src/*.ko $INSTALL/$(get_full_module_dir)/$PKG_NAME
}
