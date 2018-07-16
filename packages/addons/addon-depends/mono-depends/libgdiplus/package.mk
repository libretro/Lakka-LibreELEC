# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libgdiplus"
PKG_VERSION="5.6"
PKG_SHA256="6a75e4a476695cd6a1475fd6b989423ecf73978fd757673669771d8a6e13f756"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/mono/libgdiplus"
PKG_URL="https://github.com/mono/libgdiplus/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain cairo giflib glib libjpeg-turbo tiff"
PKG_LONGDESC="An Open Source implementation of the GDI+ API"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-shared               \
                           --with-libgif=$TARGET_PREFIX  \
                           --with-libjpeg=$TARGET_PREFIX \
                           --with-libtiff=$TARGET_PREFIX"

if [ "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libXext libexif"
else
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --without-x11"
fi

makeinstall_target() {
  make install DESTDIR=$INSTALL
}
