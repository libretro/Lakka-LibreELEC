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

PKG_NAME="diskdev_cmds"
PKG_VERSION="332.14"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="APSL"
PKG_SITE="http://src.gnu-darwin.org/DarwinSourceArchive/expanded/diskdev_cmds/"
PKG_URL="http://www.opensource.apple.com/tarballs/diskdev_cmds/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="openssl"
PKG_BUILD_DEPENDS_TARGET="toolchain openssl"
PKG_BUILD_DEPENDS_INIT="toolchain openssl diskdev_cmds"
PKG_PRIORITY="optional"
PKG_SECTION="system"
PKG_SHORTDESC="diskdev_cmds: hfs filesystem utilities"
PKG_LONGDESC="The fsck and mkfs utliities for hfs and hfsplus filesystems."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_MAKE_OPTS_TARGET="-f Makefile.lnx CC=$CC"

pre_make_target() {
  export CFLAGS="$TARGET_CFLAGS -g3 -Wall -I$PKG_BUILD/include -DDEBUG_BUILD=0 -D_FILE_OFFSET_BITS=64 -D LINUX=1 -D BSD=1"
}

makeinstall_target() {
  mkdir -p $INSTALL/bin
    cp fsck_hfs.tproj/fsck_hfs $INSTALL/bin
      ln -sf fsck_hfs $INSTALL/bin/fsck.hfs
      ln -sf fsck_hfs $INSTALL/bin/fsck.hfsplus
}

make_init() {
  : # we reuse make_target()
}

makeinstall_init() {
  mkdir -p $INSTALL/bin
    cp fsck_hfs.tproj/fsck_hfs $INSTALL/bin
}
