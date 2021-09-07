# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libXft"
PKG_VERSION="2.3.4"
PKG_SHA256="57dedaab20914002146bdae0cb0c769ba3f75214c4c91bd2613d6ef79fc9abdd"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="https://xorg.freedesktop.org/archive/individual/lib/libXft-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain fontconfig freetype libXrender util-macros xorgproto"
PKG_LONGDESC="X FreeType library."
PKG_BUILD_FLAGS="+pic -sysroot"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared"
