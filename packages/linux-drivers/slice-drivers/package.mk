# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="slice-drivers"
PKG_VERSION="8a2bdcd5dc182de899f19b0935d8beeb7f5fdbcb"
PKG_SHA256="ffb3b9ef5a0e6101d661407447257abf136f1ae206a17bd18d9b204e0b29f050"
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/LibreELEC/slice-drivers"
PKG_URL="https://github.com/LibreELEC/slice-drivers/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_LONGDESC="linux kernel modules for the Slice box"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  kernel_make KDIR=$(kernel_path)
}

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_module_dir)/$PKG_NAME
    cp *.ko $INSTALL/$(get_full_module_dir)/$PKG_NAME
}
