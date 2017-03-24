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

PKG_NAME="inotify-tools"
PKG_VERSION="1df9af4"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="http://wiki.github.com/rvoicilas/inotify-tools/"
PKG_URL="https://github.com/rvoicilas/$PKG_NAME/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="inotify-tools"
PKG_LONGDESC="a C library and a set of command-line programs for Linux providing a simple interface to inotify"
PKG_AUTORECONF="yes"

PKG_IS_ADDON="no"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared"

pre_configure_target() {
  CFLAGS="$CFLAGS -Wno-error=misleading-indentation"
}

makeinstall_target() {
  : nothing to do
}
