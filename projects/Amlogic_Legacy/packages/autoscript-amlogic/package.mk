# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="autoscript-amlogic"
PKG_VERSION=""
PKG_LICENSE="GPL"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Autoscript package for Amlogic devices"
PKG_TOOLCHAIN="manual"

make_target() {
  for src in $PKG_DIR/scripts/*autoscript.src ; do
    $TOOLCHAIN/bin/mkimage -A $TARGET_KERNEL_ARCH -O linux -T script -C none -d "$src" "$(basename $src .src)" > /dev/null
  done
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/bootloader
  cp -a $PKG_BUILD/*autoscript $INSTALL/usr/share/bootloader/
}
