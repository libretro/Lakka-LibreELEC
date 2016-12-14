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

PKG_NAME="btrfs-progs"
PKG_VERSION="4.8.4"
PKG_REV="100"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://btrfs.wiki.kernel.org/index.php/Main_Page"
PKG_URL="https://github.com/kdave/btrfs-progs/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain util-linux zlib lzo"
PKG_SECTION="tools"
PKG_SHORTDESC="tools for the btrfs filesystem"
PKG_LONGDESC="tools for the btrfs filesystem"
PKG_AUTORECONF="no"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="BTRFS Tools"
PKG_ADDON_TYPE="xbmc.python.script"

PKG_CONFIGURE_OPTS_TARGET="--disable-backtrace \
                           --disable-documentation \
                           --disable-convert"

pre_configure_target() {
  ./autogen.sh
}

makeinstall_target() {
  :
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin/
    cp -P $(get_build_dir btrfs-progs)/{btrfs,btrfsck,btrfstune,btrfs-zero-log,fsck.btrfs,mkfs.btrfs} $ADDON_BUILD/$PKG_ADDON_ID/bin
}
