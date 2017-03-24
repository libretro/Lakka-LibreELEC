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

PKG_NAME="ngrep"
PKG_VERSION="1.45"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://ngrep.sourceforge.net/"
PKG_URL="http://prdownloads.sourceforge.net/ngrep/ngrep-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libpcap"
PKG_SECTION="network/analyzer"
PKG_SHORTDESC="ngrep - network grep"
PKG_LONGDESC="ngrep - network grep"
PKG_DISCLAIMER="this is an unofficial addon. please don't ask for support in openelec forum / irc channel"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="--with-pcap-includes=$SYSROOT_PREFIX/usr/include --disable-dropprivs"

pre_build_target() {
  mkdir -p $PKG_BUILD/.$TARGET_NAME
  cp -RP $PKG_BUILD/* $PKG_BUILD/.$TARGET_NAME
}

makeinstall_target() {
  : # nop
}
