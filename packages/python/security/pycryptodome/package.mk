# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pycryptodome"
PKG_VERSION="3.8.2"
PKG_SHA256="5bc40f8aa7ba8ca7f833ad2477b9d84e1bfd2630b22a46d9bbd221982f8c3ac0"
PKG_LICENSE="BSD"
PKG_SITE="https://pypi.org/project/pycryptodome"
PKG_URL="https://files.pythonhosted.org/packages/source/${PKG_NAME:0:1}/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python2 distutilscross:host"
PKG_LONGDESC="PyCryptodome is a self-contained Python package of low-level cryptographic primitives."
PKG_TOOLCHAIN="manual"

pre_configure_target() {
  cd $PKG_BUILD
  rm -rf .$TARGET_NAME

  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
  export LDSHARED="$CC -shared"
}

make_target() {
  python setup.py build --cross-compile
}

makeinstall_target() {
  python setup.py install --root=$INSTALL --prefix=/usr

  # Remove SelfTest bloat
  find $INSTALL -type d -name SelfTest -exec rm -fr "{}" \; 2>/dev/null || true
  find $INSTALL -name SOURCES.txt -exec sed -i "/\/SelfTest\//d;" "{}" \;

  # Create Cryptodome as an alternative namespace to Crypto (Kodi addons may use either)
  ln -sf /usr/lib/$PKG_PYTHON_VERSION/site-packages/Crypto $INSTALL/usr/lib/$PKG_PYTHON_VERSION/site-packages/Cryptodome
}

post_makeinstall_target() {
  find $INSTALL/usr/lib -name "*.py" -exec rm -rf "{}" ";"
}
