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

PKG_NAME="bkeymaps"
PKG_VERSION="1.13"
PKG_SHA256="59d41ddb0c7a92d8ac155a82ed2875b7880c8957ea4308afa633c8b81e5b8887"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.alpinelinux.org"
PKG_URL="http://dev.alpinelinux.org/archive/bkeymaps/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain busybox"
PKG_SECTION="system"
PKG_SHORTDESC="bkeymaps: binary keyboard maps for busybox"
PKG_LONGDESC="bkeymaps: binary keyboard maps for busybox"
PKG_AUTORECONF="no"

make_target() {
  : # nothing todo, we install manually
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/keymaps
    cp -PR bkeymaps/* $INSTALL/usr/lib/keymaps
}
