################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
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

PKG_NAME="mediainfo"
PKG_VERSION="0.7.83"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://mediaarea.net/en/MediaInfo/Download/Source"
PKG_URL="http://mediaarea.net/download/source/mediainfo/$PKG_VERSION/mediainfo_$PKG_VERSION.tar.bz2"
PKG_SOURCE_DIR="MediaInfo"
PKG_DEPENDS_TARGET="toolchain libmediainfo"
PKG_SECTION="tools"
PKG_SHORTDESC="MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files"
PKG_LONGDESC="MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files"
PKG_AUTORECONF="no"

make_target() {
  cd Project/GNU/CLI
  do_autoreconf
  echo $PATH
  ./configure \
        --host=$TARGET_NAME \
        --build=$HOST_NAME \
        --prefix=/usr
  make
}

makeinstall_target() {
  : # nop
}
