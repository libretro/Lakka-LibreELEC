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

PKG_NAME="e2fsprogs"
PKG_VERSION="1.42.12"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://e2fsprogs.sourceforge.net/"
PKG_URL="$SOURCEFORGE_SRC/$PKG_NAME/$PKG_NAME/1.42/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_DEPENDS_INIT="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="tools"
PKG_SHORTDESC="e2fsprogs: Utilities for use with the ext2 filesystem"
PKG_LONGDESC="The filesystem utilities for the EXT2 filesystem, including e2fsck, mke2fs, dumpe2fs, fsck, and others."
PKG_IS_ADDON="no"

PKG_AUTORECONF="yes"

if [ "$HFSTOOLS" = "yes" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET diskdev_cmds"
fi

PKG_CONFIGURE_OPTS_TARGET="BUILD_CC=$HOST_CC \
                           --prefix=/usr \
                           --bindir=/bin \
                           --sbindir=/sbin \
                           --enable-verbose-makecmds \
                           --enable-symlink-install \
                           --enable-symlink-build \
                           --enable-compression \
                           --enable-htree \
                           --disable-elf-shlibs \
                           --disable-bsd-shlibs \
                           --disable-profile \
                           --disable-jbd-debug \
                           --disable-blkid-debug \
                           --disable-testio-debug \
                           --enable-libuuid \
                           --enable-libblkid \
                           --disable-debugfs \
                           --disable-imager \
                           --enable-resizer \
                           --enable-fsck \
                           --disable-e2initrd-helper \
                           --enable-tls \
                           --disable-uuidd \
                           --disable-nls \
                           --disable-rpath \
                           --with-gnu-ld"

PKG_CONFIGURE_OPTS_INIT="$PKG_CONFIGURE_OPTS_TARGET"

pre_configure_target() {
# e2fsprogs fails to build with LTO support on gcc-4.9
  strip_lto
}

post_makeinstall_target() {
  rm -rf $INSTALL/sbin/badblocks
  rm -rf $INSTALL/sbin/blkid
  rm -rf $INSTALL/sbin/dumpe2fs
  rm -rf $INSTALL/sbin/e2freefrag
  rm -rf $INSTALL/sbin/e2undo
  rm -rf $INSTALL/sbin/e4defrag
  rm -rf $INSTALL/sbin/filefrag
  rm -rf $INSTALL/sbin/fsck
  rm -rf $INSTALL/sbin/logsave
  rm -rf $INSTALL/sbin/mklost+found
}

pre_configure_init() {
# e2fsprogs fails to build with LTO support on gcc-4.9
  strip_lto
}

makeinstall_init() {
  mkdir -p $INSTALL/sbin
    cp e2fsck/e2fsck $INSTALL/sbin
    ln -sf e2fsck $INSTALL/sbin/fsck.ext2
    ln -sf e2fsck $INSTALL/sbin/fsck.ext3
    ln -sf e2fsck $INSTALL/sbin/fsck.ext4
    ln -sf e2fsck $INSTALL/sbin/fsck.ext4dev
}
