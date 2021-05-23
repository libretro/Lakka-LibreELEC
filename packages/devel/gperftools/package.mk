# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gperftools"
PKG_VERSION="2.9.1"
PKG_SHA256="ea566e528605befb830671e359118c2da718f721c27225cbbc93858c7520fee3"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/gperftools/gperftools"
PKG_URL="https://github.com/gperftools/gperftools/releases/download/gperftools-${PKG_VERSION}/gperftools-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Google Performance Tools"

PKG_CONFIGURE_OPTS_TARGET="--enable-minimal --disable-debugalloc --disable-static"
