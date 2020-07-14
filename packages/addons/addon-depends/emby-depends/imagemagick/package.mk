# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="imagemagick"
PKG_VERSION="7.0.10-23"
PKG_SHA256="27f8a24858cc5658aa07a13002a41d342b88e5c4e1917ff4d503dbbf8cbff91c"
PKG_LICENSE="http://www.imagemagick.org/script/license.php"
PKG_SITE="http://www.imagemagick.org/"
PKG_URL="https://github.com/ImageMagick/ImageMagick/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Software suite to create, edit, compose, or convert bitmap images"

PKG_CONFIGURE_OPTS_TARGET="--disable-openmp \
                           --disable-static \
                           --enable-shared \
                           --with-pango=no \
                           --with-utilities=no \
                           --with-x=no"

makeinstall_target() {
  make install DESTDIR=$INSTALL $PKG_MAKEINSTALL_OPTS_TARGET
}
