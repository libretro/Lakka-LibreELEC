# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="unrar"
PKG_VERSION="5.6.3"
PKG_SHA256="c590e70a745d840ae9b9f05ba6c449438838c8280d76ce796a26b3fcd0a1972e"
PKG_LICENSE="free"
PKG_SITE="http://www.rarlab.com"
PKG_URL="http://www.rarlab.com/rar/unrarsrc-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="unrar extract, test and view RAR archives"
PKG_TOOLCHAIN="manual"

make_target() {
  make CXX="$CXX" \
     CXXFLAGS="$TARGET_CXXFLAGS" \
     RANLIB="$RANLIB" \
     AR="$AR" \
     STRIP="$STRIP" \
     -f makefile
}
