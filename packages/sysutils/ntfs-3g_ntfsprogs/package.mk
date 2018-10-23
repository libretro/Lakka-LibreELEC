# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="ntfs-3g_ntfsprogs"
PKG_VERSION="2017.3.23"
PKG_SHA256="3e5a021d7b761261836dcb305370af299793eedbded731df3d6943802e1262d5"
PKG_LICENSE="GPL"
PKG_SITE="http://www.ntfs-3g.org/"
PKG_URL="http://tuxera.com/opensource/$PKG_NAME-$PKG_VERSION.tgz"
PKG_DEPENDS_TARGET="toolchain fuse libgcrypt"
PKG_LONGDESC="A NTFS driver with read and write support."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+lto"

PKG_CONFIGURE_OPTS_TARGET="--exec-prefix=/usr/ \
                           --disable-dependency-tracking \
                           --disable-library \
                           --enable-posix-acls \
                           --enable-mtab \
                           --enable-ntfsprogs \
                           --disable-crypto \
                           --with-fuse=external \
                           --with-uuid"

post_makeinstall_target() {
  # dont include ntfsprogs.
  for i in $INSTALL/usr/bin/*; do
    if [ "$(basename $i)" != "ntfs-3g" ]; then
      rm $i
    fi
  done

  rm -rf $INSTALL/sbin
  rm -rf $INSTALL/usr/sbin/ntfsclone
  rm -rf $INSTALL/usr/sbin/ntfscp
  rm -rf $INSTALL/usr/sbin/ntfsundelete

  mkdir -p $INSTALL/usr/sbin
    ln -sf /usr/bin/ntfs-3g $INSTALL/usr/sbin/mount.ntfs
    ln -sf /usr/sbin/mkntfs $INSTALL/usr/sbin/mkfs.ntfs
}
