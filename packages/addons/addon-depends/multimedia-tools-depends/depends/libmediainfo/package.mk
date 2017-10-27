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

PKG_NAME="libmediainfo"
PKG_VERSION="0.7.99"
PKG_SHA256="d48277ad9f71d421b40a8c1c254d33246ee6d787358c39f08adc62000edbc550" 
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://mediaarea.net/en/MediaInfo/Download/Source"
PKG_URL="https://github.com/MediaArea/MediaInfoLib/archive/v$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="MediaInfoLib-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain libzen zlib"
PKG_SECTION="multimedia"
PKG_SHORTDESC="MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files"
PKG_LONGDESC="MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files"
PKG_TOOLCHAIN="manual"

make_target() {
  cd Project/GNU/Library
  do_autoreconf
  ./configure \
        --host=$TARGET_NAME \
        --build=$HOST_NAME \
        --enable-static \
        --disable-shared \
        --prefix=/usr \
        --enable-visibility \
        --disable-libcurl \
        --disable-libmms
  make
}

post_makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/include/MediaInfo
  cp -aP ../../../Source/MediaInfo/* $SYSROOT_PREFIX/usr/include/MediaInfo
  for i in Archive Audio Duplicate Export Image Multiple Reader Tag Text Video ; do
    mkdir -p $SYSROOT_PREFIX/usr/include/MediaInfo/$i/
    cp -aP ../../../Source/MediaInfo/$i/*.h $SYSROOT_PREFIX/usr/include/MediaInfo/$i/
  done
  cp -P libmediainfo-config $TOOLCHAIN/bin
}
