# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pyalsaaudio"
PKG_VERSION="0.8.4"
PKG_SHA256="84e8f8da544d7f4bd96479ce4a237600077984d9be1d7f16c1d9a492ecf50085"
PKG_LICENSE="PSF"
PKG_SITE="http://larsimmisch.github.io/pyalsaaudio/"
PKG_URL="https://files.pythonhosted.org/packages/source/${PKG_NAME:0:1}/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python2 distutilscross:host alsa-lib"
PKG_LONGDESC="ALSA bindings"
PKG_TOOLCHAIN="manual"

make_target() {
  export LDSHARED="$CC -shared"
  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
  python setup.py build --cross-compile
}

makeinstall_target() {
  python setup.py install --root=$INSTALL --prefix=/usr
  find $INSTALL/usr/lib -name "*.py" -exec rm -rf "{}" ";"
  rm -rf $INSTALL/usr/lib/python*/site-packages/*.egg-info \
         $INSTALL/usr/lib/python*/site-packages/*/tests
}
