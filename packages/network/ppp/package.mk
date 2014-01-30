################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="ppp"
PKG_VERSION="2.4.5"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://samba.org/"
PKG_URL="http://samba.org/ftp/ppp/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libpcap"
PKG_PRIORITY="optional"
PKG_SECTION="network"
PKG_SHORTDESC="ppp: contains the pppd daemon and the chat program. This is used for connecting to other machines; often for connecting to the Internet via a dial-up or PPPoE connection to an ISP."
PKG_LONGDESC="The PPP package contains the pppd daemon and the chat program. This is used for connecting to other machines; often for connecting to the Internet via a dial-up or PPPoE connection to an ISP."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_configure_target() {
# ppp fails to build in subdirs
  cd $ROOT/$PKG_BUILD
    rm -rf .$TARGET_NAME

# ppp-2.4.5 contains an out of date copy of the kernel header linux/if_pppol2tp.h.
# This needs to be removed to force it to use the one installed in /usr. If you don't
# remove this file the build will still succeed (thanks to a poorly written Makefile)
# but it will fail to compile the openl2tp.so, pppol2tp.so and rp-pppoe.so plugins
  rm -rf include/linux/if_pppol2tp.h
}

make_target() {
  make COPTS="$CFLAGS"
}

makeinstall_target() {
  make DESTDIR=$SYSROOT_PREFIX/usr install-devel
  make DESTDIR=$INSTALL/usr install
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/sbin/chat
  rm -rf $INSTALL/usr/sbin/pppdump
  rm -rf $INSTALL/usr/sbin/pppoe-discovery
  rm -rf $INSTALL/usr/sbin/pppstats
}
