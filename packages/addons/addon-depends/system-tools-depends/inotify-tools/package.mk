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

PKG_NAME="inotify-tools"
PKG_VERSION="3.20.1"
PKG_SHA256="a433cc1dedba851078276db69b0e97f9fe41e4ba3336d2971adfca4b3a6242ac"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="http://wiki.github.com/rvoicilas/inotify-tools/"
PKG_URL="https://github.com/rvoicilas/inotify-tools/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_LONGDESC="a C library and a set of command-line programs for Linux providing a simple interface to inotify"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared --disable-doxygen"

pre_configure_target() {
  CFLAGS="$CFLAGS -Wno-error=misleading-indentation"
}

makeinstall_target() {
  :
}
