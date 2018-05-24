################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="tstools"
PKG_VERSION="db1f79f"
PKG_SHA256="f204229016c9deafcc75fe602c390339878312126134edbfcebf239e093dc4ff"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kynesim/tstools"
PKG_URL="https://github.com/kynesim/tstools/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_LONGDESC="This is a set of cross-platform command line tools for working with MPEG data."
PKG_BUILD_FLAGS="-parallel"

make_target() {
  make CROSS_COMPILE=$TARGET_PREFIX
}

makeinstall_target() {
  :
}
