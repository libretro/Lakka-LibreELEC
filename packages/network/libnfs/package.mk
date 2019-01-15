# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libnfs"
PKG_VERSION="38b62bcf873c778ebde79707bb0409b6a09ee608"
PKG_SHA256="12e8e2e142ca4c41e1f1a22ce6e88b205bacdedfa29daaff91a5d54cf834ea61"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/sahlberg/libnfs"
PKG_URL="https://github.com/sahlberg/libnfs/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A client library for accessing NFS shares over a network."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--disable-examples"

pre_configure_target() {
  export CFLAGS="$CFLAGS -D_FILE_OFFSET_BITS=64"
}
