# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="RTL8812AU"
PKG_VERSION="e9fbf5c051453941bbc029810b893a6c010714e6"
PKG_SHA256="a79f06b1b2d9fd880cddebe7723b7e46abf9a8ba1c40c1eee6498c623913cadb"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/aircrack-ng/rtl8812au"
PKG_URL="https://github.com/aircrack-ng/rtl8812au/archive/$PKG_VERSION.tar.gz"
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
