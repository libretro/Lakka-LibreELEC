# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="RTL8812AU"
PKG_VERSION="45ea063b03846e8a8c9fc04b2f9c2090bbe9b46b"
PKG_SHA256="99e407dac59bab34262f2f2f10db314a733c0644e940d7ed7759f65858db1dd9"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/MilhouseVH/RTL8812AU"
PKG_URL="https://github.com/MilhouseVH/RTL8812AU/archive/$PKG_VERSION.tar.gz"
PKG_LONGDESC="Realtek RTL8812AU Linux 3.x driver"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  make V=1 \
       ARCH=$TARGET_KERNEL_ARCH \
       KSRC=$(kernel_path) \
       CROSS_COMPILE=$TARGET_KERNEL_PREFIX \
       CONFIG_POWER_SAVING=n
}

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_module_dir)/$PKG_NAME
    cp *.ko $INSTALL/$(get_full_module_dir)/$PKG_NAME
}
