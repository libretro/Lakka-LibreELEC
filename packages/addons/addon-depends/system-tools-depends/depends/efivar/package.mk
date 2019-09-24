# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="efivar"
PKG_VERSION="3e687d8072f3ed53ae727ec2cb99ae56dbcdf02b"
PKG_SHA256="810d386c9f4dafc160c721ef73e491c933c311e3df768e27eec50c28ac0f4d97"
PKG_ARCH="x86_64"
PKG_LICENSE="LGPL"
PKG_SITE="https://github.com/rhboot/efivar"
PKG_URL="https://github.com/rhboot/efivar/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="gcc:host"
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
