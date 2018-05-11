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

PKG_NAME="unrar"
PKG_VERSION="5.6.3"
PKG_SHA256="c590e70a745d840ae9b9f05ba6c449438838c8280d76ce796a26b3fcd0a1972e"
PKG_ARCH="any"
PKG_LICENSE="free"
PKG_SITE="http://www.rarlab.com"
PKG_URL="http://www.rarlab.com/rar/unrarsrc-$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="${PKG_NAME}"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_LONGDESC="unrar extract, test and view RAR archives"
PKG_TOOLCHAIN="manual"

make_target() {
  make CXX="$CXX" \
     CXXFLAGS="$TARGET_CXXFLAGS" \
     RANLIB="$RANLIB" \
     AR="$AR" \
     STRIP="$STRIP" \
     -f makefile
}
