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

PKG_NAME="dosfstools"
PKG_VERSION="3.0.28"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/dosfstools/dosfstools"
PKG_URL="https://github.com/dosfstools/dosfstools/releases/download/v$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_DEPENDS_INIT="toolchain dosfstools"
PKG_PRIORITY="optional"
PKG_SECTION="tools"
PKG_SHORTDESC="dosfstools: utilities for making and checking MS-DOS FAT filesystems."
PKG_LONGDESC="dosfstools contains utilities for making and checking MS-DOS FAT filesystems."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_MAKE_OPTS_TARGET="PREFIX=/usr"
PKG_MAKEINSTALL_OPTS_TARGET="PREFIX=/usr"

make_init() {
  : # reuse make_target()
}

pre_build_host() {
  mkdir -p $PKG_BUILD/.$HOST_NAME
  cp -RP $PKG_BUILD/* $PKG_BUILD/.$HOST_NAME
}

make_host() {
  cd $ROOT/$PKG_BUILD/.$HOST_NAME
  make PREFIX=/usr
}

makeinstall_init() {
  mkdir -p $INSTALL/sbin
    cp fsck.fat $INSTALL/sbin
    ln -sf fsck.fat $INSTALL/sbin/fsck.msdos
    ln -sf fsck.fat $INSTALL/sbin/fsck.vfat
}

makeinstall_host() {
  mkdir -p $ROOT/$TOOLCHAIN/sbin
    cp mkfs.fat $ROOT/$TOOLCHAIN/sbin
    ln -sf mkfs.fat $ROOT/$TOOLCHAIN/sbin/mkfs.vfat
}
