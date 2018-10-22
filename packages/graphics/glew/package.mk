# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="glew"
PKG_VERSION="1.13.0"
PKG_SHA256="aa25dc48ed84b0b64b8d41cdd42c8f40f149c37fa2ffa39cd97f42c78d128bc7"
PKG_LICENSE="BSD"
PKG_SITE="http://glew.sourceforge.net/"
PKG_URL="$SOURCEFORGE_SRC/glew/glew/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tgz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A cross-platform C/C++ extension loading library."

make_target() {
  make CC="$CC" LD="$CC" AR="$AR" \
       POPT="$CFLAGS" LDFLAGS.EXTRA="$LDFLAGS" \
       GLEW_DEST="/usr" LIBDIR="/usr/lib" lib/libGLEW.a glew.pc
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp -PR lib/libGLEW.a $SYSROOT_PREFIX/usr/lib

  mkdir -p $SYSROOT_PREFIX/usr/lib/pkgconfig
    cp -PR glew.pc $SYSROOT_PREFIX/usr/lib/pkgconfig

  mkdir -p $SYSROOT_PREFIX/usr/include
    cp -PR include/GL $SYSROOT_PREFIX/usr/include
}
