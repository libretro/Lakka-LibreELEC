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

PKG_NAME="iana-etc"
PKG_VERSION="2.30"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.linuxfromscratch.org/lfs/view/development/chapter06/iana-etc.html"
PKG_URL="http://anduin.linuxfromscratch.org/sources/LFS/lfs-packages/conglomeration/iana-etc/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="network"
PKG_SHORTDESC="iana-etc: The Iana-Etc package provides data for network services and protocols."
PKG_LONGDESC="The Iana-Etc package provides data for network services and protocols."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

post_make_target() {
  sed -e 's,^sunrpc,rpcbind,' -i services
}

makeinstall_target() {
  mkdir -p $INSTALL/etc
    cp protocols $INSTALL/etc
    cp services $INSTALL/etc
}
