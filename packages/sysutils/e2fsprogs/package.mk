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

PKG_NAME="e2fsprogs"
PKG_VERSION="1.43.3"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://e2fsprogs.sourceforge.net/"
PKG_URL="$SOURCEFORGE_SRC/$PKG_NAME/$PKG_NAME/1.42/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_DEPENDS_INIT="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="e2fsprogs: Utilities for use with the ext2 filesystem"
PKG_LONGDESC="The filesystem utilities for the EXT2 filesystem, including e2fsck, mke2fs, dumpe2fs, fsck, and others."
PKG_IS_ADDON="no"

PKG_AUTORECONF="no"

if [ "$HFSTOOLS" = "yes" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET diskdev_cmds"
fi

PKG_CONFIGURE_OPTS_HOST="--prefix=/usr \
                         --bindir=/bin \
                         --sbindir=/sbin"

PKG_CONFIGURE_OPTS_TARGET="BUILD_CC=$HOST_CC \
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

pre_make_host() {
  # dont build parallel
  MAKEFLAGS=-j1
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/sbin/badblocks
  rm -rf $INSTALL/usr/sbin/blkid
  rm -rf $INSTALL/usr/sbin/dumpe2fs
  rm -rf $INSTALL/usr/sbin/e2freefrag
  rm -rf $INSTALL/usr/sbin/e2undo
  rm -rf $INSTALL/usr/sbin/e4defrag
  rm -rf $INSTALL/usr/sbin/filefrag
  rm -rf $INSTALL/usr/sbin/fsck
  rm -rf $INSTALL/usr/sbin/logsave
  rm -rf $INSTALL/usr/sbin/mklost+found
}

makeinstall_init() {
  mkdir -p $INSTALL/usr/sbin
    cp e2fsck/e2fsck $INSTALL/usr/sbin
    ln -sf e2fsck $INSTALL/usr/sbin/fsck.ext2
    ln -sf e2fsck $INSTALL/usr/sbin/fsck.ext3
    ln -sf e2fsck $INSTALL/usr/sbin/fsck.ext4
    ln -sf e2fsck $INSTALL/usr/sbin/fsck.ext4dev

  if [ $INITRAMFS_PARTED_SUPPORT = "yes" ]; then
    cp misc/mke2fs $INSTALL/usr/sbin
    ln -sf mke2fs $INSTALL/usr/sbin/mkfs.ext2
    ln -sf mke2fs $INSTALL/usr/sbin/mkfs.ext3
    ln -sf mke2fs $INSTALL/usr/sbin/mkfs.ext4
    ln -sf mke2fs $INSTALL/usr/sbin/mkfs.ext4dev
  fi
}

make_host() {
  make -C lib/et
  make -C lib/ext2fs
}

makeinstall_host() {
  make -C lib/et DESTDIR=$(pwd)/.install install
  make -C lib/ext2fs DESTDIR=$(pwd)/.install install

  rm -fr $(pwd)/.install/bin
  rm -fr $(pwd)/.install/usr/share

  # Ensure installed files are writeable and not read-only, otherwise future package bumps will fail to overwrite toolchain
  chmod -R +w $(pwd)/.install/usr/*

  cp -Pa $(pwd)/.install/usr/* $TOOLCHAIN
}

