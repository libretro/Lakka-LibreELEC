# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aom"
PKG_VERSION="51b282d13d5ee58dadf45164fc49a6e034333478"
PKG_SHA256="15a2f7960da99f865bd4da1e60b110e2220115851d60a1bb042465ff99c0bc83"
PKG_LICENSE="BSD"
PKG_SITE="https://www.webmproject.org"
PKG_URL="http://repo.or.cz/aom.git/snapshot/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="AV1 Codec Library"

PKG_CMAKE_OPTS_TARGET="-DENABLE_CCACHE=1 \
                       -DENABLE_DOCS=0 \
                       -DENABLE_TOOLS=0"
