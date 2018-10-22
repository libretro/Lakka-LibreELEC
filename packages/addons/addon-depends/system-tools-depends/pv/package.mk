# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pv"
PKG_VERSION="1.6.0"
PKG_SHA256="9dd45391806b0ed215abee4c5ac1597d018c386fe9c1f5afd2f6bc3b07fd82c3"
PKG_LICENSE="GNU"
PKG_SITE="http://www.ivarch.com/programs/pv.shtml"
PKG_URL="http://www.ivarch.com/programs/sources/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Pipe Viwer can be inserted into any normal pipeline between two processes."

PKG_CONFIGURE_OPTS_TARGET="--enable-static-nls"

makeinstall_target() {
        : # nop
}
