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

PKG_NAME="lzo"
PKG_VERSION="2.10"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.oberhumer.com/opensource/lzo"
PKG_URL="http://www.oberhumer.com/opensource/lzo/download/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST=""
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="compress"
PKG_SHORTDESC="LZO data compressor"
PKG_LONGDESC="LZO is a data compression library which is suitable for data de-/compression in real-time. This means it favours speed over compression ratio."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CMAKE_OPTS_HOST="-DENABLE_SHARED=OFF -DENABLE_STATIC=ON"
PKG_CMAKE_OPTS_TARGET="-DENABLE_SHARED=OFF -DENABLE_STATIC=ON"
