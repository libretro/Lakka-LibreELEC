# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

. $(get_pkg_directory rsync)/package.mk

PKG_NAME="rsyncx"
PKG_DEPENDS_TARGET="toolchain"

PKG_CONFIGURE_OPTS_TARGET="--disable-acl-support \
                           --disable-xattr-support \
                           --with-included-popt"

makeinstall_target() {
  :
}
