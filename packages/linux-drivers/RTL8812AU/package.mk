# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="RTL8812AU"
PKG_VERSION="8af27f5bebe1c890879fb2cc50e672a7f55c6505"
PKG_SHA256="6badcf35d7f42e0f906000d7cf59b0afcdc7d97f41de16e54158cf53e1518c58"
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
