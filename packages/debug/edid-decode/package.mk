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

PKG_NAME="edid-decode"
PKG_VERSION="f56f329"
PKG_SHA256="d9347ddf6933c6f90c79230b1898da5686083f0e5ebb7ef67acb011108cfaeae"
PKG_ARCH="any"
PKG_LICENSE="None"
PKG_SITE="https://cgit.freedesktop.org/xorg/app/edid-decode/"
PKG_URL="https://cgit.freedesktop.org/xorg/app/edid-decode/snapshot/$PKG_VERSION.tar.xz"
PKG_SOURCE_DIR="$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="debug"
PKG_SHORTDESC="Decode EDID data in human-readable format"
PKG_LONGDESC="Decode EDID data in human-readable format"

make_target() {
  echo "$CC $CFLAGS -Wall $LDFLAGS -lm -o edid-decode edid-decode.c"
  $CC $CFLAGS -Wall $LDFLAGS -lm -o edid-decode edid-decode.c
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp edid-decode $INSTALL/usr/bin
}
