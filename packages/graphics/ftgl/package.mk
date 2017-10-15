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

PKG_NAME="ftgl"
PKG_VERSION="2.1.2"
PKG_SHA256="0f61d978c28cd5d78daded591f5b03f71248c0a51c7965733e8729c874265f50"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://sourceforge.net/projects/ftgl/"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain freetype"
PKG_SECTION="multimedia"
PKG_SHORTDESC="a free cross-platform Open Source C++ library that uses Freetype2 to simplify rendering fonts in OpenGL applications"
PKG_LONGDESC="a free cross-platform Open Source C++ library that uses Freetype2 to simplify rendering fonts in OpenGL applications"
PKG_AUTORECONF="no"

PKG_CMAKE_OPTS_TARGET="-DOUTPUT_DIR=$SYSROOT_PREFIX/usr"
