# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="initramfs"
PKG_VERSION=""
PKG_LICENSE="GPL"
PKG_SITE="http://www.openelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain libc:init busybox:init linux:init plymouth-lite:init util-linux:init e2fsprogs:init dosfstools:init fakeroot:host"
PKG_SECTION="virtual"
PKG_LONGDESC="debug is a Metapackage for installing initramfs"

if [ "$ISCSI_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET open-iscsi:init"
fi

if [ "$INITRAMFS_PARTED_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET parted:init"
fi

post_install() {
  ( cd $BUILD/initramfs
    if [ "$TARGET_ARCH" = "x86_64" ]; then
      ln -sf /usr/lib $BUILD/initramfs/lib64
      mkdir -p $BUILD/initramfs/usr
      ln -sf /usr/lib $BUILD/initramfs/usr/lib64
    fi

    ln -sf /usr/lib $BUILD/initramfs/lib
    ln -sf /usr/bin $BUILD/initramfs/bin
    ln -sf /usr/sbin $BUILD/initramfs/sbin

    mkdir -p $BUILD/image/
    fakeroot -- sh -c \
      "mkdir -p dev; mknod -m 600 dev/console c 5 1; find . | cpio -H newc -ov -R 0:0 > $BUILD/image/initramfs.cpio"
  )
}
