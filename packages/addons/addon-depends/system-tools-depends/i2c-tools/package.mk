# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="i2c-tools"
PKG_VERSION="3.1.2"
PKG_SHA256="6d6079153cd49a62d4addacef4c092db1a46ba60b2807070a3fbe050262aef87"
PKG_LICENSE="GPL"
PKG_SITE="https://i2c.wiki.kernel.org/index.php/I2C_Tools"
PKG_URL="https://www.kernel.org/pub/software/utils/i2c-tools/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain Python3 distutilscross:host"
PKG_LONGDESC="A heterogeneous set of I2C tools for Linux."
PKG_BUILD_FLAGS="-sysroot"

pre_make_target() {
  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
  export LDSHARED="$CC -shared"
}

make_target() {
  make  EXTRA="py-smbus" \
        CC="$CC" \
        AR="$TARGET_AR" \
        CFLAGS="$TARGET_CFLAGS" \
        CPPFLAGS="$TARGET_CPPFLAGS -I${SYSROOT_PREFIX}/usr/include/$PKG_PYTHON_VERSION" \
        PYTHON=${TOOLCHAIN}/bin/python3
}

makeinstall_target() {
  make  DESTDIR=${INSTALL} \
        prefix="/usr" \
        EXTRA="py-smbus" \
        PYTHON=${TOOLCHAIN}/bin/python3 \
        install
}
