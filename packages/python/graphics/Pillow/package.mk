# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="Pillow"
PKG_VERSION="9.4.0"
PKG_SHA256="494cee55efe8733d9744ba2d96fec067a15e22f37e6aefa14b01cc630e7cfb8c"
PKG_LICENSE="BSD"
PKG_SITE="https://python-pillow.org/"
PKG_URL="https://github.com/python-pillow/${PKG_NAME}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3 distutilscross:host zlib freetype libjpeg-turbo tiff"
PKG_LONGDESC="The Python Imaging Library adds image processing capabilities to your Python interpreter."
PKG_TOOLCHAIN="manual"

pre_make_target() {
  export PYTHONXCPREFIX="${SYSROOT_PREFIX}/usr"
  export LDSHARED="${CC} -shared"
}

make_target() {
  python3 setup.py build --cross-compile
}

makeinstall_target() {
  python3 setup.py install --root=${INSTALL} --prefix=/usr
}

post_makeinstall_target() {
  python_remove_source

  rm -rf ${INSTALL}/usr/bin
}
