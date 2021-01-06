# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aixlog"
PKG_VERSION="1.4.0"
PKG_SHA256="cce5b8f5408cfd19b4d4eb678274d0c74490dc0eb2bdc8f97c852036897d6099"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/badaix/aixlog"
PKG_URL="https://github.com/badaix/aixlog/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Header-only C++ logging library."
PKG_BUILD_FLAGS="-sysroot"

PKG_CMAKE_OPTS_TARGET="-DBUILD_EXAMPLE=OFF"
