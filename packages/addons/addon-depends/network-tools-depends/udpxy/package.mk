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

PKG_NAME="udpxy"
PKG_VERSION="1.0.23-0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.udpxy.com/download-en.html"
PKG_URL="$SOURCEFORGE_SRC/project/udpxy/udpxy/Chipmunk-1.0/${PKG_NAME}.${PKG_VERSION}-prod.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="udpxy is a UDP-to-HTTP multicast traffic relay daemon"
PKG_LONGDESC="udpxy is a UDP-to-HTTP multicast traffic relay daemon"
PKG_DISCLAIMER="this is an unofficial addon. please don't ask for support in openelec forum / irc channel"
PKG_AUTORECONF="no"

pre_configure_target() {
  # fails to build with gcc 4.9 + lto
  strip_lto
  CFLAGS="$CFLAGS -Wno-error=unused-const-variable"
}

makeinstall_target() {
  : # nop
}
