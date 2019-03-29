# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rsync"
PKG_VERSION="3.1.3"
PKG_SHA256="55cc554efec5fdaad70de921cd5a5eeb6c29a95524c715f3bbf849235b0800c0"
PKG_LICENSE="GPLv3"
PKG_SITE="http://www.samba.org/ftp/rsync/rsync.html"
PKG_URL="https://download.samba.org/pub/rsync/src/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A very fast method for bringing remote files into sync."

PKG_CONFIGURE_OPTS_TARGET="--disable-acl-support \
                           --disable-xattr-support \
                           --with-included-popt"

makeinstall_target() {
  :
}
