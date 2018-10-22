# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="i2c-tools"
PKG_VERSION="3.1.2"
PKG_SHA256="f939a6242c03950cc568d0efdfa3db7a9c29e0e8f5abd01f2908bdd344c054ff"
PKG_LICENSE="GPL"
PKG_SITE="http://www.lm-sensors.org/wiki/I2CTools"
PKG_URL="http://fossies.org/linux/misc/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python2 distutilscross:host"
PKG_LONGDESC="A heterogeneous set of I2C tools for Linux."

pre_make_target() {
  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
  export LDSHARED="$CC -shared"
}

make_target() {
  make  EXTRA="py-smbus" \
        CC="$CC" \
        AR="$TARGET_AR" \
        CFLAGS="$TARGET_CFLAGS" \
        CPPFLAGS="$TARGET_CPPFLAGS -I${SYSROOT_PREFIX}/usr/include/$PKG_PYTHON_VERSION"
}

makeinstall_target() {
  : # nop
}
