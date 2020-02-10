# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="intel_nuc_led"
PKG_VERSION="6a3850eadff554053ca7d95e830a624b28c53670"
PKG_SHA256="14313183b1ef547dcc43cf943695f227bb456b8acd634fe12b4345e471b53b36"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/milesp20/intel_nuc_led/"
PKG_URL="https://github.com/milesp20/intel_nuc_led/archive/$PKG_VERSION.tar.gz"
PKG_LONGDESC="Intel NUC7i[x]BN and NUC6CAY LED Control for Linux"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  kernel_make KDIR=$(kernel_path) default
}

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_module_dir)/$PKG_NAME
    cp *.ko $INSTALL/$(get_full_module_dir)/$PKG_NAME
}
