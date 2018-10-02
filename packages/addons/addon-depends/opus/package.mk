# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="opus"
PKG_VERSION="1.3-rc2"
PKG_SHA256="f6bab321fb81db984766f1e4d340a9e71a5ca2c5d4d53f4ee072e84afda271ca"
PKG_LICENSE="BSD"
PKG_SITE="http://www.opus-codec.org"
PKG_URL="https://archive.mozilla.org/pub/opus/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Codec designed for interactive speech and audio transmission over the Internet"

if [ "$TARGET_ARCH" = "arm" ]; then
  PKG_FIXED_POINT="--enable-fixed-point"
else
  PKG_FIXED_POINT="--disable-fixed-point"
fi

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           $PKG_FIXED_POINT"
