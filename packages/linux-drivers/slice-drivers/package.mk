# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="slice-drivers"
PKG_VERSION="d02f3e7"
PKG_SHA256="31c32eba1549c8cf6204c5cfdd25ec0480bcc95c0253f06258596189c84926ca"
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/LibreELEC/slice-drivers"
PKG_URL="https://github.com/LibreELEC/slice-drivers/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="driver"
PKG_SHORTDESC="linux kernel modules for the Slice box"
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
