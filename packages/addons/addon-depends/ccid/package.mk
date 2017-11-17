################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017-present Team LibreELEC
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

PKG_NAME="ccid"
PKG_VERSION="1.4.28"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="http://pcsclite.alioth.debian.org/ccid.html"
PKG_URL="https://alioth.debian.org/frs/download.php/latestfile/112/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain pcsc-lite"
PKG_SECTION="driver"
PKG_SHORTDESC="CCID free software driver"
PKG_LONGDESC="CCID free software driver"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --enable-twinserial"

make_target() {
  make
  make -C src/ Info.plist
}
