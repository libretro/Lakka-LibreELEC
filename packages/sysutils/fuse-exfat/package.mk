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

PKG_NAME="fuse-exfat"
PKG_VERSION="1.1.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://code.google.com/p/exfat"
#PKG_URL="http://exfat.googlecode.com/files/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_URL="http://distfiles.gentoo.org/distfiles/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain scons:host fuse"
PKG_PRIORITY="optional"
PKG_SECTION="system"
PKG_SHORTDESC="fuse-exfat: aims to provide a full-featured exFAT file system implementation for GNU/Linux other Unix-like systems as a FUSE module."
PKG_LONGDESC="This project aims to provide a full-featured exFAT file system implementation for GNU/Linux other Unix-like systems as a FUSE module."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"


make_target() {
  export CCFLAGS="$CFLAGS -std=c99"

  scons
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp fuse/mount.exfat-fuse $INSTALL/usr/bin
    ln -sf mount.exfat-fuse $INSTALL/usr/bin/mount.exfat
}
