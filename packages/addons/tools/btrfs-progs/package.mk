# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="btrfs-progs"
PKG_VERSION="6.8.1"
PKG_SHA256="9aa72e2646a8ed5e24d37cb70af4e3e526ba5a541fc547c5613e11ced05ab490"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://btrfs.readthedocs.io/"
PKG_URL="https://github.com/kdave/btrfs-progs/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain util-linux zlib systemd lzo"
PKG_SECTION="tools"
PKG_SHORTDESC="Tools for the btrfs filesystem"
PKG_LONGDESC="Tools for the btrfs filesystem"
PKG_TOOLCHAIN="configure"

PKG_BUILD_FLAGS="-sysroot"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="BTRFS Tools"
PKG_ADDON_TYPE="xbmc.python.script"

PKG_CONFIGURE_OPTS_TARGET="--disable-backtrace \
                           --disable-convert \
                           --disable-documentation \
                           --disable-python \
                           --disable-zstd"

pre_configure_target() {
  ./autogen.sh
}

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/
    cp -P ${PKG_INSTALL}/usr/bin/{btrfs,btrfsck,btrfstune,fsck.btrfs,mkfs.btrfs} ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
}
