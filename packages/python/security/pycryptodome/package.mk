################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017-present Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="pycryptodome"
PKG_VERSION="3.4.5"
PKG_SHA256="be84544eadc2bb71d4ace39e4984ed2990111f053f24267a07afb4b4e1e5428f"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="https://pypi.python.org/pypi/pycryptodome"
PKG_URL="https://files.pythonhosted.org/packages/source/${PKG_NAME:0:1}/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python2 distutilscross:host"
PKG_SECTION="python/security"
PKG_SHORTDESC="Cryptographic library for Python"
PKG_LONGDESC="PyCryptodome is a self-contained Python package of low-level cryptographic primitives."
PKG_AUTORECONF="no"

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
