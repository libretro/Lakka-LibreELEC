# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="libjpeg-turbo"
PKG_VERSION="1.5.3"
PKG_SHA256="b24890e2bb46e12e72a79f7e965f409f4e16466d00e1dd15d93d73ee6b592523"
PKG_LICENSE="GPL"
PKG_SITE="http://libjpeg-turbo.virtualgl.org/"
PKG_URL="$SOURCEFORGE_SRC/libjpeg-turbo/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="toolchain"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A high-speed version of libjpeg for x86 and x86-64 processors which uses SIMD."
PKG_TOOLCHAIN="configure"
PKG_BUILD_FLAGS="+pic +pic:host"

PKG_CONFIGURE_OPTS_HOST="--enable-static \
                         --disable-shared \
                         --with-jpeg8 \
                         --without-simd"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared --with-jpeg8"

if ! target_has_feature "(neon|sse)"; then
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --without-simd"
fi

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
