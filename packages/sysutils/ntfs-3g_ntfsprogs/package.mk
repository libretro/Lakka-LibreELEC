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

PKG_NAME="ntfs-3g_ntfsprogs"
PKG_VERSION="2016.2.22"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.ntfs-3g.org/"
PKG_URL="http://tuxera.com/opensource/$PKG_NAME-$PKG_VERSION.tgz"
PKG_DEPENDS_TARGET="toolchain fuse"
PKG_SECTION="system"
PKG_SHORTDESC="ntfs-3g_ntfsprogs: NTFS-3G Read/Write userspace driver"
PKG_LONGDESC="The NTFS-3G_ntfsprogs driver is an open source, freely available NTFS driver for Linux with read and write support. It provides safe and fast handling of the Windows XP, Windows Server 2003, Windows 2000 and Windows Vista file systems."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

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
