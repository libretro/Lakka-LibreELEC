# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="Pillow"
PKG_VERSION="7.0.0"
PKG_SHA256="4d9ed9a64095e031435af120d3c910148067087541131e82b3e8db302f4c8946"
PKG_LICENSE="BSD"
PKG_SITE="http://www.pythonware.com/products/pil/"
PKG_URL="https://files.pythonhosted.org/packages/source/${PKG_NAME:0:1}/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3 distutilscross:host zlib freetype libjpeg-turbo tiff"
PKG_LONGDESC="The Python Imaging Library adds image processing capabilities to your Python interpreter."
PKG_TOOLCHAIN="manual"

pre_make_target() {
  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
  export LDSHARED="$CC -shared"
}

make_target() {
  python3 setup.py build --cross-compile
}

makeinstall_target() {
  python3 setup.py install --root=$INSTALL --prefix=/usr
}

post_makeinstall_target() {
  python_remove_source

  rm -rf $INSTALL/usr/bin
}
