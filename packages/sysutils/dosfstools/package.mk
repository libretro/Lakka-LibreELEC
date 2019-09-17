# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dosfstools"
PKG_VERSION="3.0.28"
PKG_SHA256="ee95913044ecf2719b63ea11212917649709a6e53209a72d622135aaa8517ee2"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/dosfstools/dosfstools"
PKG_URL="https://github.com/dosfstools/dosfstools/releases/download/v$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_HOST="gcc:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_DEPENDS_INIT="toolchain dosfstools"
PKG_LONGDESC="dosfstools contains utilities for making and checking MS-DOS FAT filesystems."

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
  cd $PKG_BUILD/.$HOST_NAME
  make PREFIX=/usr
}

makeinstall_init() {
  mkdir -p $INSTALL/usr/sbin
    cp fsck.fat $INSTALL/usr/sbin
    ln -sf fsck.fat $INSTALL/usr/sbin/fsck.msdos
    ln -sf fsck.fat $INSTALL/usr/sbin/fsck.vfat
}

makeinstall_host() {
  mkdir -p $TOOLCHAIN/sbin
    cp mkfs.fat $TOOLCHAIN/sbin
    ln -sf mkfs.fat $TOOLCHAIN/sbin/mkfs.vfat
    cp fsck.fat $TOOLCHAIN/sbin
    ln -sf fsck.fat $TOOLCHAIN/sbin/fsck.vfat
    cp fatlabel $TOOLCHAIN/sbin
}
