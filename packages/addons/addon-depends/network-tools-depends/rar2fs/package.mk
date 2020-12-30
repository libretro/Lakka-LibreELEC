# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rar2fs"
PKG_VERSION="1.29.3"
PKG_SHA256="e813ad62cccdc6081f00c081eb09b435e6ed58422a8f83e222e1aa9d7a0f0866"
PKG_LICENSE="GPL3"
PKG_SITE="https://github.com/hasse69/rar2fs"
PKG_URL="https://github.com/hasse69/rar2fs/releases/download/v$PKG_VERSION/rar2fs-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain fuse unrar"
PKG_LONGDESC="FUSE file system for reading RAR archives"
PKG_BUILD_FLAGS="-sysroot"

pre_configure_target() {
  PKG_CONFIGURE_OPTS_TARGET="--with-unrar=$PKG_BUILD/unrar \
                             --with-unrar-lib=$PKG_BUILD/unrar \
                             --disable-static-unrar"
  cp -a $(get_install_dir unrar)/usr/include/unrar $PKG_BUILD/
  cp -p $(get_install_dir unrar)/usr/lib/libunrar.a $PKG_BUILD/unrar/
}
