# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="efibootmgr"
PKG_VERSION="95f7a63"
PKG_SHA256="a6f936508c5b50b6fb5693dd2f0db911da298da0f72ffc0e2e74b09b22592fd1"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/vathpela/efibootmgr"
PKG_URL="https://github.com/vathpela/efibootmgr-devel/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="efibootmgr-devel-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain efivar pciutils zlib"
PKG_SECTION="tools"
PKG_SHORTDESC="EFI Boot Manager"
PKG_LONGDESC="This is a Linux user-space application to modify the Intel Extensible Firmware Interface (EFI) Boot Manager configuration. This application can create and destroy boot entries, change the boot order, change the next running boot option, and more."

pre_make_target() {
  export EXTRA_CFLAGS="$CFLAGS -I$SYSROOT_PREFIX/usr/include -I$SYSROOT_PREFIX/usr/include/efivar -fgnu89-inline"
  export LDFLAGS="$LDFLAGS -L$SYSROOT_PREFIX/usr/lib -ludev -ldl"
}

makeinstall_target() {
  : # nop
}
