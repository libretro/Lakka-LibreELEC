# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="efivar"
PKG_VERSION="836461e480e2249de134efeaef79588cab045d5c"
PKG_SHA256="30d0e3cbe3ef38d80ceceacd07d1be3667a4d36ff426bbb2b1621e27ebd7ee20"
PKG_ARCH="x86_64"
PKG_LICENSE="LGPL"
PKG_SITE="https://github.com/rhboot/efivar"
PKG_URL="https://github.com/rhboot/efivar/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain efivar:host"
PKG_LONGDESC="Tools and library to manipulate EFI variables."

make_host() {
  make -C src/ include/efivar/efivar-guids.h
}

make_target() {
  make -C src/ libefivar.a libefiboot.a efivar.h efivar
}

makeinstall_host() {
  : # noop
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp -P src/libefivar.a src/libefiboot.a $SYSROOT_PREFIX/usr/lib/

  mkdir -p $SYSROOT_PREFIX/usr/include/efivar
    cp -P src/include/efivar/*.h $SYSROOT_PREFIX/usr/include/efivar
}
