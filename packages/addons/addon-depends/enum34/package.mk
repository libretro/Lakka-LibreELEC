# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="enum34"
PKG_VERSION="1.1.6"
PKG_SHA256="b09c7f7ee925e600bd4efaa5fef49919eacdbdfd5a52e0696c5d03010cffb9ec"
PKG_LICENSE="BSD"
PKG_SITE="https://bitbucket.org/stoneleaf/enum34"
PKG_URL="https://bitbucket.org/stoneleaf/$PKG_NAME/get/$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain Python2 distutilscross:host"
PKG_LONGDESC="Python 3.4 Enum backported to 3.3, 3.2, 3.1, 2.7, 2.6, 2.5, and 2.4."
PKG_TOOLCHAIN="manual"

make_target() {
  python setup.py build
}
