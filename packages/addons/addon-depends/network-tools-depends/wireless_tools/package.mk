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

PKG_NAME="wireless_tools"
PKG_VERSION="29"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html"
PKG_URL="http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/$PKG_NAME.$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="${PKG_NAME}.${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="debug/tools"
PKG_SHORTDESC="wireless-tools: tools allowing to manipulate the Wireless Extensions"
PKG_LONGDESC="The Wireless Tools (WT) is a set of tools allowing to manipulate the Wireless Extensions. They use a textual interface and are rather crude, but aim to support the full Wireless Extension. There are many other tools you can use with Wireless Extensions, however Wireless Tools is the reference implementation."
PKG_AUTORECONF="no"

pre_configure_Target() {
  # wireless_tools fails to build on some systems with LTO enabled
  strip_lto
}

make_target() {
  make PREFIX=/usr CC="$CC" AR="$AR" \
     CFLAGS="$CFLAGS" CPPFLAGS="$CPPFLAGS" iwmulticall
}

makeinstall_target() {
  : # nop
}
