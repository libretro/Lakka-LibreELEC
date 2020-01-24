# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pycryptodome"
PKG_VERSION="3.9.4"
PKG_SHA256="a168e73879619b467072509a223282a02c8047d932a48b74fbd498f27224aa04"
PKG_LICENSE="BSD"
PKG_SITE="https://pypi.org/project/pycryptodome"
PKG_URL="https://files.pythonhosted.org/packages/source/${PKG_NAME:0:1}/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3 distutilscross:host"
PKG_LONGDESC="PyCryptodome is a self-contained Python package of low-level cryptographic primitives."
PKG_TOOLCHAIN="manual"

pre_configure_target() {
  cd $PKG_BUILD
  rm -rf .$TARGET_NAME

  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
  export LDSHARED="$CC -shared"
}

make_target() {
  python3 setup.py build --cross-compile
}

makeinstall_target() {
  python3 setup.py install --root=$INSTALL --prefix=/usr

  # Remove SelfTest bloat
  find $INSTALL -type d -name SelfTest -exec rm -fr "{}" \; 2>/dev/null || true
  find $INSTALL -name SOURCES.txt -exec sed -i "/\/SelfTest\//d;" "{}" \;

  # Create Cryptodome as an alternative namespace to Crypto (Kodi addons may use either)
  ln -sf /usr/lib/$PKG_PYTHON_VERSION/site-packages/Crypto $INSTALL/usr/lib/$PKG_PYTHON_VERSION/site-packages/Cryptodome
}

post_makeinstall_target() {
  python_remove_source
}
