################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="libdvbcsa"
PKG_VERSION="aae3d0c"
PKG_SHA256="2c0b69a5ca70c5032f9375a57bcec449ecdf93b5459f60f087f5fa06c605c7c1"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.videolan.org/developers/libdvbcsa.html"
PKG_SITE="https://github.com/glenvt18/libdvbcsa/"
PKG_URL="https://github.com/glenvt18/libdvbcsa/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="lib"
PKG_SHORTDESC="libdvbcsa is a free implementation of the DVB Common Scrambling Algorithm - DVB/CSA - with encryption and decryption capabilities"
PKG_LONGDESC="libdvbcsa is a free implementation of the DVB Common Scrambling Algorithm - DVB/CSA - with encryption and decryption capabilities"
PKG_TOOLCHAIN="autotools"
# libdvbcsa is a bit faster without LTO, and tests will fail with gcc-5.x
PKG_BUILD_FLAGS="-lto +pic"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared --enable-static --with-sysroot=$SYSROOT_PREFIX"

if target_has_feature neon; then
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --enable-neon"
elif [ "$TARGET_ARCH" = x86_64  ]; then
  if target_has_feature ssse3; then
    PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --enable-ssse3"
  elif target_has_feature sse2; then
    PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --enable-sse2"
  else
    PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --enable-uint64"
  fi
fi
