# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="szap-s2"
PKG_VERSION="69ff358"
PKG_SHA256="eea8d99d2d5d6403d624acdd9df908a2dd7767dd5469b44e9a281ff863096b32"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://bitbucket.org/updatelee/tune-s2"
PKG_URL="https://bitbucket.org/CrazyCat/szap-s2/get/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="CrazyCat-${PKG_NAME}-${PKG_VERSION}*"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="szap-s2 is a simple zapping tool for the Linux DVB S2 API"
PKG_LONGDESC="szap-s2 is a simple zapping tool for the Linux DVB S2 API"

makeinstall_target() {
  :
}
