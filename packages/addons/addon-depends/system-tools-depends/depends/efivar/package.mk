# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="efivar"
PKG_VERSION="70e63d4"
# 0.15 # Todo: later versions with buildproblems
PKG_SHA256="2638f1faa22e67bf99b4c537f7c21c336a5851a8c91c8dc09555da946a1b84c9"
PKG_ARCH="x86_64"
PKG_LICENSE="LGPL"
PKG_SITE="https://github.com/vathpela/efivar"
PKG_URL="https://github.com/vathpela/efivar-devel/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain efivar:host"
PKG_LONGDESC="Tools and library to manipulate EFI variables."

make_host() {
  make -C src/ makeguids
}

make_target() {
  make -C src/ libefivar.a efivar-guids.h efivar.h
}

makeinstall_host() {
  : # noop
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp -P src/libefivar.a $SYSROOT_PREFIX/usr/lib/

  mkdir -p $SYSROOT_PREFIX/usr/include/efivar
    cp -P src/efivar.h $SYSROOT_PREFIX/usr/include/efivar
    cp -P src/efivar-guids.h $SYSROOT_PREFIX/usr/include/efivar
}
