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

PKG_NAME="rewritefs"
PKG_VERSION="33fb844"
PKG_ARCH="any"
PKG_SITE="https://github.com/sloonz/rewritefs"
PKG_URL="https://github.com/sloonz/rewritefs/archive/33fb844d8e8ff441a3fc80d2715e8c64f8563d81.tar.gz"
PKG_DEPENDS_TARGET="toolchain fuse pcre"
PKG_SECTION="tools"
PKG_SHORTDESC="A FUSE filesystem intended to be used like Apache mod_rewrite"
PKG_MAKE_OPTS_TARGET="PREFIX=/usr"
PKG_TOOLCHAIN="make"

pre_make_target() {
  export CFLAGS="$TARGET_CFLAGS"
  export CPPFLAGS="$TARGET_CPPFLAGS"
  export LDFLAGS="$TARGET_LDFLAGS"
  export CROSS_COMPILE="$TARGET_PREFIX"
}

makeinstall_target() {
	DESTDIR=$INSTALL/usr make install
}
