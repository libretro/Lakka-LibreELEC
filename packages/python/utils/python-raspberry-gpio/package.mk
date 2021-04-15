# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="python-raspberry-gpio"
PKG_VERSION="0.7.0"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="http://sourceforge.net/projects/raspberry-gpio-python"
PKG_URL="https://files.pythonhosted.org/packages/source/R/RPi.GPIO/RPi.GPIO-${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR="RPi.GPIO-${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain Python2 distutilscross:host"
PKG_SECTION="python"

PKG_TOOLCHAIN="manual"

pre_make_target() {
  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
  export LDSHARED="$CC -shared"
}

make_target() {
  : nop
}

makeinstall_target() {
  python setup.py install --root=$INSTALL --prefix=/usr
}

post_makeinstall_target() {
  find $INSTALL/usr/lib -name "*.py" -exec rm -rf "{}" ";"
}
