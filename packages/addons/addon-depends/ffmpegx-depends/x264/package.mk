################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="x264"
PKG_VERSION="snapshot-20180220-2245"
PKG_SHA256="80090285b40983776793168a3828dfd8125caca06cb6949511d64946d6166882"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.videolan.org/developers/x264.html"
PKG_URL="https://download.videolan.org/x264/snapshots/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="multimedia"
PKG_SHORTDESC="x264"
PKG_LONGDESC="x264"

pre_configure_target() {
  cd $PKG_BUILD
  rm -rf .$TARGET_NAME
}

configure_target() {
  ./configure \
    --prefix="/usr" \
    --extra-cflags="$CFLAGS" \
    --extra-ldflags="$LDFLAGS" \
    --disable-cli \
    --enable-static \
    --enable-strip \
    --disable-asm \
    --enable-pic \
    --host="$TARGET_NAME" \
    --cross-prefix="$TARGET_PREFIX" \
    --sysroot="$SYSROOT_PREFIX"
}
