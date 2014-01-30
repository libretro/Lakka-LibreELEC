################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="cloog"
PKG_VERSION="0.18.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.cloog.org/"
PKG_URL="http://www.bastoul.net/cloog/pages/download/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="ccache:host gmp:host"
PKG_PRIORITY="optional"
PKG_SECTION="toolchain/math"
PKG_SHORTDESC="cloog: a free software and library to generate code for scanning Z-polyhedra."
PKG_LONGDESC="CLooG is a library to generate code for scanning Z-polyhedra. In other words, it finds code that reaches each integral point of one or more parameterized polyhedra. GCC links with this library in order to enable the new loop generation code known as Graphite."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

# TODO: automake 1.13 support must be fixed

PKG_CONFIGURE_OPTS_HOST="--target=$TARGET_NAME \
                         --enable-shared \
                         --disable-static \
                         --disable-silent-rules \
                         --with-gnu-ld \
                         --with-isl=buildin \
                         --with-gmp=system \
                         --with-gmp-prefix=$ROOT/$TOOLCHAIN"
