# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rar2fs"
PKG_VERSION="1.29.5"
PKG_SHA256="a56e9f2fd3d5037087b8405cff85ce7ffb74a904176f33f55b7bd15117cff2be"
PKG_LICENSE="GPL3"
PKG_SITE="https://github.com/hasse69/rar2fs"
PKG_URL="https://github.com/hasse69/rar2fs/releases/download/v${PKG_VERSION}/rar2fs-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain fuse unrar"
PKG_LONGDESC="FUSE file system for reading RAR archives"
PKG_BUILD_FLAGS="-sysroot"

pre_configure_target() {
  PKG_CONFIGURE_OPTS_TARGET="--with-unrar=${PKG_BUILD}/unrar \
                             --with-unrar-lib=${PKG_BUILD}/unrar \
                             --disable-static-unrar"
  cp -a $(get_install_dir unrar)/usr/include/unrar ${PKG_BUILD}/
  cp -p $(get_install_dir unrar)/usr/lib/libunrar.a ${PKG_BUILD}/unrar/
}
