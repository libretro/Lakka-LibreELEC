# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="initramfs"
PKG_VERSION=""
PKG_LICENSE="GPL"
PKG_SITE="http://www.openelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain libc:init busybox:init plymouth-lite:init util-linux:init e2fsprogs:init dosfstools:init terminus-font:init"
PKG_SECTION="virtual"
PKG_LONGDESC="debug is a Metapackage for installing initramfs"

if [ "$ISCSI_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET open-iscsi:init"
fi

if [ "$INITRAMFS_PARTED_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET parted:init"
fi

if [ "$PROJECT" = "Gamegirl" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET gamegirl-screen:init"
fi

