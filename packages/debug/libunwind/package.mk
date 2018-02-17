################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2018-present Team LibreELEC
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

PKG_NAME="libunwind"
PKG_VERSION="1.2.1"
PKG_SHA256="3f3ecb90e28cbe53fba7a4a27ccce7aad188d3210bb1964a923a731a27a75acb"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.nongnu.org/libunwind/"
PKG_URL="http://download.savannah.nongnu.org/releases/libunwind/libunwind-${PKG_VERSION}.tar.gz"
PKG_SECTION="debug"
PKG_SHORTDESC="library to determine the call-chain of a program"
PKG_LONGDESC="library to determine the call-chain of a program"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
			   --disable-shared"

makeinstall_target() {
  make DESTDIR=$SYSROOT_PREFIX install
}
