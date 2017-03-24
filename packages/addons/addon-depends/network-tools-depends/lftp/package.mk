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

PKG_NAME="lftp"
PKG_VERSION="4.7.4"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://lftp.yar.ru/"
PKG_URL="http://lftp.yar.ru/ftp/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain readline openssl zlib"
PKG_SECTION="tools"
PKG_SHORTDESC="ftp client"
PKG_LONGDESC="LFTP is a sophisticated ftp/http client, and a file transfer program supporting a number of network protocols"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="--disable-nls \
                           --without-gnutls \
                           --with-openssl \
                           --with-readline=$SYSROOT_PREFIX/usr \
                           --with-zlib=$SYSROOT_PREFIX/usr"

makeinstall_target() {
  : # nop
}
