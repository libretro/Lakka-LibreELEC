# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="netbase"
PKG_VERSION="6.3"
PKG_SHA256="7c42a6a1cafa0c64103c71cab6431fc8613179b2449a1a00e55e3584e860d81c"
PKG_LICENSE="GPL"
PKG_SITE="https://salsa.debian.org/md/netbase"
PKG_URL="http://ftp.debian.org/debian/pool/main/n/netbase/netbase_${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="The netbase package provides data for network services and protocols from the iana db."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/etc
    cp etc/protocols ${INSTALL}/etc
    cp etc/services ${INSTALL}/etc
}
