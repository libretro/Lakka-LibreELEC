################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017-present Team LibreELEC
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

PKG_NAME="netbase"
PKG_VERSION="5.4"
PKG_SHA256="66ff73d2d162e2d49db43988d8b8cd328cf7fffca042db73397f14c71825e80d"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://anonscm.debian.org/cgit/users/md/netbase.git/"
PKG_URL="http://ftp.debian.org/debian/pool/main/n/netbase/netbase_$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="network"
PKG_SHORTDESC="The netbase package provides data for network services and protocols from the iana db."
PKG_LONGDESC="The netbase package provides data for network services and protocols from the iana db."
PKG_AUTORECONF="no"

make_target() {
  :
}

makeinstall_target() {
  mkdir -p $INSTALL/etc
    cp etc-protocols $INSTALL/etc/protocols
    cp etc-services $INSTALL/etc/services
}
