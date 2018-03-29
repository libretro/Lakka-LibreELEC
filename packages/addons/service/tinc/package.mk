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

PKG_NAME="tinc"
PKG_VERSION="1.1pre15"
PKG_SHA256="05745d96463aed584474e9bdaf869865911b169d9bc5199ee5f1b1986ea3d7c7"
PKG_REV="103"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="http://www.tinc-vpn.org/"
PKG_URL="https://github.com/gsliepen/tinc/archive/release-$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="tinc-release-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain lzo miniupnpc openssl zlib"
PKG_SECTION="service/system"
PKG_SHORTDESC="tinc: a Virtual Private Network daemon"
PKG_LONGDESC="tinc ($PKG_VERSION) is a Virtual Private Network (VPN) daemon that uses tunnelling and encryption to create a secure private network between hosts on the Internet. Because the VPN appears to the IP level network code as a normal network device, there is no need to adapt any existing software. This allows VPN sites to share information with each other over the Internet without exposing any information to others."
PKG_TOOLCHAIN="autotools"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="tinc"
PKG_ADDON_TYPE="xbmc.service"
PKG_MAINTAINER="Anton Voyl (awiouy)"

PKG_CONFIGURE_OPTS_TARGET="--disable-curses \
                           --disable-readline \
                           --enable-miniupnpc \
                           --sysconfdir=/run"
PKG_MAKE_OPTS_TARGET="SUBDIRS=src"
PKG_MAKEINSTALL_OPTS_TARGET="SUBDIRS=src"

make_target() {
  :
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp $PKG_BUILD/.install_pkg/usr/sbin/* \
     $ADDON_BUILD/$PKG_ADDON_ID/bin
}
