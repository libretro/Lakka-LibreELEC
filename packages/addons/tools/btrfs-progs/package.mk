# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="btrfs-progs"
PKG_VERSION="4.8.4"
PKG_SHA256="4741764daa4eee9179ae1d366f25b08e8ec99a2857bab03487e6a991f26a25ff"
PKG_REV="101"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://btrfs.wiki.kernel.org/index.php/Main_Page"
PKG_URL="https://github.com/kdave/btrfs-progs/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain util-linux zlib lzo"
PKG_SECTION="tools"
PKG_SHORTDESC="tools for the btrfs filesystem"
PKG_LONGDESC="tools for the btrfs filesystem"
PKG_TOOLCHAIN="configure"

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
