# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="unrar"
PKG_VERSION="5.6.8"
PKG_SHA256="a4cc0ac14a354827751912d2af4a0a09e2c2129df5766576fa7e151791dd3dff"
PKG_LICENSE="free"
PKG_SITE="http://www.rarlab.com"
PKG_URL="http://www.rarlab.com/rar/unrarsrc-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="unrar extract, test and view RAR archives"
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="+pic"

make_target() {
  make CXX="$CXX" \
     CXXFLAGS="$TARGET_CXXFLAGS" \
     RANLIB="$RANLIB" \
     AR="$AR" \
     STRIP="$STRIP" \
     -f makefile unrar

  make clean

  make CXX="$CXX" \
     CXXFLAGS="$TARGET_CXXFLAGS" \
     RANLIB="$RANLIB" \
     AR="$AR" \
     -f makefile lib
}

post_make_target() {
  rm -f libunrar.so
}
