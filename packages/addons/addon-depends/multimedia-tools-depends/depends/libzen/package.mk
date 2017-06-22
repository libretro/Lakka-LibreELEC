################################################################################
#      This file is part of LibreELEC - http://www.libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
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

PKG_NAME="libzen"
PKG_VERSION="0.4.33"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://mediaarea.net/en/MediaInfo/"
PKG_URL="http://mediaarea.net/download/source/libzen/$PKG_VERSION/libzen_$PKG_VERSION.tar.bz2"
PKG_SOURCE_DIR="ZenLib"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="multimedia"
PKG_SHORTDESC="MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files"
PKG_LONGDESC="MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  cd Project/GNU/Library
  do_autoreconf
  ./configure \
        --host=$TARGET_NAME \
        --build=$HOST_NAME \
        --enable-static \
        --disable-shared \
        --prefix=/usr

  make
}

post_makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/include/ZenLib
  cp -aP ../../../Source/ZenLib/*.h $SYSROOT_PREFIX/usr/include/ZenLib
  for i in HTTP_Client Format/Html Format/Http ; do
    mkdir -p $SYSROOT_PREFIX/usr/include/ZenLib/$i/
    cp -aP ../../../Source/ZenLib/$i/*.h $SYSROOT_PREFIX/usr/include/ZenLib/$i/
  done
  cp -P libzen-config $TOOLCHAIN/bin
}
