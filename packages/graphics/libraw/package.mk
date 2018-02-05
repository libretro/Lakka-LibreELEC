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

PKG_NAME="libraw"
PKG_VERSION="0.18.7"
PKG_SHA256="87e347c261a8e87935d9a23afd750d27676b99f540e8552314d40db0ea315771"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.libraw.org/"
PKG_URL="http://www.libraw.org/data/LibRaw-$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="LibRaw-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain libjpeg-turbo"
PKG_SECTION="graphics"
PKG_SHORTDESC="A library for reading RAW files obtained from digital photo cameras (CRW/CR2, NEF, RAF, DNG, and others)"
PKG_LONGDESC="A library for reading RAW files obtained from digital photo cameras (CRW/CR2, NEF, RAF, DNG, and others)"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --disable-openmp \
                           --enable-jpeg \
                           --disable-jasper \
                           --disable-lcms \
                           --disable-examples \
                           --disable-demosaic-pack-gpl2 \
                           --disable-demosaic-pack-gpl3"
