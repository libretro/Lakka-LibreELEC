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

PKG_NAME="initramfs"
PKG_VERSION=""
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.openelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain libc:init busybox:init linux:init plymouth-lite:init util-linux:init e2fsprogs:init dosfstools:init"
PKG_PRIORITY="optional"
PKG_SECTION="virtual"
PKG_SHORTDESC="initramfs: Metapackage for installing initramfs"
PKG_LONGDESC="debug is a Metapackage for installing initramfs"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$ISCSI_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET open-iscsi:init"
fi

if [ "$INITRAMFS_PARTED_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET util-linux:init"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET e2fsprogs:init"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET parted:init"
fi

post_install() {
  cd $ROOT/$BUILD/initramfs
    if [ "$TARGET_ARCH" = "x86_64" -o "$TARGET_ARCH" = "powerpc64" ]; then
      ln -s /lib $ROOT/$BUILD/initramfs/lib64
    fi
    mkdir -p $ROOT/$BUILD/image/
    find . | cpio -H newc -ov -R 0:0 > $ROOT/$BUILD/image/initramfs.cpio
  cd -
}
