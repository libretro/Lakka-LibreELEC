################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2018-present Team LibreELEC
#      Copyright (C) 2017 Escalade
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

PKG_NAME="cups"
PKG_VERSION="2.2.8"
PKG_SHA256="8f87157960b9d80986f52989781d9de79235aa060e05008e4cf4c0a6ef6bca72"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.cups.org"
PKG_URL="https://github.com/apple/cups/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain openssl zlib"
PKG_LONGDESC="CUPS printing system"
PKG_BUILD_FLAGS="+pic"

pre_configure_target() {
  cd ..
  rm -rf .$TARGET_NAME
}

PKG_CONFIGURE_OPTS_TARGET="--libdir=/usr/lib \
                           --disable-gssapi \
                           --disable-avahi \
                           --disable-systemd \
                           --disable-launchd \
                           --disable-unit-tests"

makeinstall_target() {
  make BUILDROOT="$INSTALL/../.INSTALL_PKG"
}
