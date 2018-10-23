# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="flac"
PKG_VERSION="1.3.2"
PKG_SHA256="91cfc3ed61dc40f47f050a109b08610667d73477af6ef36dcad31c31a4a8d53f"
PKG_LICENSE="GPLv2"
PKG_SITE="https://xiph.org/flac/"
PKG_URL="http://downloads.xiph.org/releases/flac/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain libogg"
PKG_LONGDESC="An Free Lossless Audio Codec."
PKG_TOOLCHAIN="autotools"
# flac-1.3.1 dont build with LTO support
PKG_BUILD_FLAGS="+pic"

# package specific configure options
PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --disable-rpath \
                           --disable-altivec \
                           --disable-doxygen-docs \
                           --disable-thorough-tests \
                           --disable-cpplibs \
                           --disable-xmms-plugin \
                           --disable-oggtest \
                           --with-ogg=$SYSROOT_PREFIX/usr \
                           --with-gnu-ld"

if target_has_feature sse; then
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --enable-sse"
else
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --disable-sse"
fi

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
