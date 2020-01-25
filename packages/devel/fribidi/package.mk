# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="fribidi"
PKG_VERSION="1.0.8"
PKG_SHA256="94c7b68d86ad2a9613b4dcffe7bbeb03523d63b5b37918bdf2e4ef34195c1e6c"
PKG_LICENSE="LGPL"
PKG_SITE="http://fribidi.freedesktop.org/"
PKG_URL="https://github.com/fribidi/fribidi/releases/download/v$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A bidirectional algorithm library."
PKG_TOOLCHAIN="meson"
PKG_BUILD_FLAGS="+pic"

PKG_MESON_OPTS_TARGET="-Ddeprecated=false \
                       -Ddocs=false \
                       -Ddefault_library=static"

post_makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/bin
    cp -f $PKG_DIR/scripts/fribidi-config $SYSROOT_PREFIX/usr/bin
    chmod +x $SYSROOT_PREFIX/usr/bin/fribidi-config

  rm -rf $INSTALL/usr/bin
}
