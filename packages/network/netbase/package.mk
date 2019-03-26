# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="netbase"
PKG_VERSION="5.4"
PKG_SHA256="66ff73d2d162e2d49db43988d8b8cd328cf7fffca042db73397f14c71825e80d"
PKG_LICENSE="GPL"
PKG_SITE="https://anonscm.debian.org/cgit/users/md/netbase.git/"
PKG_URL="http://ftp.debian.org/debian/pool/main/n/netbase/netbase_$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="The netbase package provides data for network services and protocols from the iana db."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/etc
    cp etc-protocols $INSTALL/etc/protocols
    cp etc-services $INSTALL/etc/services
}
