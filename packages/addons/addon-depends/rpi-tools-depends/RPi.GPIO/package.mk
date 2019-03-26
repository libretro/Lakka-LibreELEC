# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="RPi.GPIO"
PKG_VERSION="0.6.3"
PKG_SHA256="a5fc0eb5e401963b6c0a03650da6b42c4005f02d962b81241d96c98d0a578516"
PKG_ARCH="arm"
PKG_LICENSE="MIT"
PKG_SITE="http://sourceforge.net/p/raspberry-gpio-python/"
PKG_URL="https://files.pythonhosted.org/packages/source/${PKG_NAME:0:1}/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python2 distutilscross:host"
PKG_LONGDESC="A module to control Raspberry Pi GPIO channels."
PKG_TOOLCHAIN="manual"

pre_configure_target() {
  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
  export LDSHARED="$CC -shared"
  export CPPFLAGS="$TARGET_CPPFLAGS -I${SYSROOT_PREFIX}/usr/include/$PKG_PYTHON_VERSION"
}

make_target() {
  python setup.py build
}
