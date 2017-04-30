################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017-present Team LibreELEC
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

PKG_NAME="pngquant"
PKG_VERSION="2.9.1"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://pngquant.org"
PKG_URL="http://pngquant.org/pngquant-${PKG_VERSION}-src.tar.gz"
PKG_DEPENDS_HOST="toolchain libpng:host zlib:host"
PKG_SECTION="graphics"
PKG_SHORTDESC="lossy PNG compressor"
PKG_LONGDESC="a PNG compresor that significantly reduces file sizes by converting images to a more efficient 8-bit PNG format"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

configure_host() {
  : #
}

make_host() {
  cd $PKG_BUILD
  BIN=$PKG_BUILD/pngquant make

  $STRIP $PKG_BUILD/pngquant
}

makeinstall_host() {
  mkdir -p $TOOLCHAIN/bin
    cp $PKG_BUILD/pngquant $TOOLCHAIN/bin
}
