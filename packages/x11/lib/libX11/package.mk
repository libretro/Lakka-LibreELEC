# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2017 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libX11"
PKG_VERSION="1.7.2"
PKG_SHA256="1cfa35e37aaabbe4792e9bb690468efefbfbf6b147d9c69d6f90d13c3092ea6c"
PKG_LICENSE="OSS"
PKG_SITE="http://www.x.org/"
PKG_URL="http://xorg.freedesktop.org/archive/individual/lib/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros xtrans libXau libxcb xorgproto"
PKG_LONGDESC="LibX11 is the main X11 library containing all the client-side code to access the X11 windowing system."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--disable-loadable-i18n \
                           --disable-loadable-xcursor \
                           --enable-xthreads \
                           --disable-xcms \
                           --enable-xlocale \
                           --disable-xlocaledir \
                           --enable-xkb \
                           --with-keysymdefdir=${SYSROOT_PREFIX}/usr/include/X11 \
                           --disable-xf86bigfont \
                           --enable-malloc0returnsnull \
                           --disable-specs \
                           --without-xmlto \
                           --without-fop \
                           --enable-composecache \
                           --disable-lint-library \
                           --disable-ipv6 \
                           --without-launchd \
                           --without-lint"
