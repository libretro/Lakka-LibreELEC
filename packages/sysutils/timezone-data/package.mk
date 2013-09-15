################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="timezone-data"
PKG_VERSION="2013d"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="Public Domain"
PKG_SITE="ftp://elsie.nci.nih.gov/pub/"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS=""
PKG_BUILD_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="system"
PKG_SHORTDESC="timezone-data"
PKG_LONGDESC="timezone-data"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  setup_toolchain host
  make CC="$HOST_CC" CFLAGS="$HOST_CFLAGS"
}

makeinstall_target() {
  make TOPDIR="./.install_pkg" install
}

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/share/zoneinfo
    mv $INSTALL/etc/zoneinfo/* $INSTALL/usr/share/zoneinfo

  rm -rf $INSTALL/man
  rm -rf $INSTALL/etc

  mkdir -p $INSTALL/etc
    ln -sf /var/run/localtime $INSTALL/etc/localtime

  mkdir -p $INSTALL/usr/lib/openelec
    cp -PR $PKG_DIR/scripts/tzdata-setup $INSTALL/usr/lib/openelec
}

post_install() {
  enable_service tz-data-monitor.path
  enable_service tz-data.service
}
