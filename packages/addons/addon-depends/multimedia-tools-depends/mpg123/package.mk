# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mpg123"
PKG_VERSION="1.25.10"
PKG_SHA256="6c1337aee2e4bf993299851c70b7db11faec785303cfca3a5c3eb5f329ba7023"
PKG_LICENSE="LGPLv2"
PKG_SITE="http://www.mpg123.org/"
PKG_URL="http://downloads.sourceforge.net/sourceforge/mpg123/mpg123-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain alsa-lib"
PKG_LONGDESC="A console based real time MPEG Audio Player for Layer 1, 2 and 3."

PKG_CONFIGURE_OPTS_TARGET="--disable-shared \
                           --enable-static"

if [ "$DISTRO" = "Lakka" ]; then
  PKG_BUILD_FLAGS="+pic"
  PKG_CONFIGURE_OPTS_TARGET="--disable-static \
                             --with-pic \
                             --enable-shared"
fi

