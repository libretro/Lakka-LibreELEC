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

PKG_NAME="file"
PKG_VERSION="5.29"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="http://www.darwinsys.com/file/"
PKG_URL="ftp://ftp.astron.com/pub/file/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="ccache:host"
PKG_DEPENDS_TARGET="toolchain zlib file:host"
PKG_SECTION="tools"
PKG_SHORTDESC="file: File type identification utility"
PKG_LONGDESC="These are the sources to Darwin's file(1) utility and master magic(4) file, now maintained by Christos Zoulas. The file(1) utility is used to determine the types of various files."
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_HOST="--enable-fsect-man5 --enable-static --disable-shared"
PKG_CONFIGURE_OPTS_TARGET="--enable-fsect-man5 --enable-static --disable-shared"

makeinstall_target() {
  : # meh
}
