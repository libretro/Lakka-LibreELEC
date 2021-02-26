# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aixlog"
PKG_VERSION="1.5.0"
PKG_SHA256="1d9d344448493c1e74e0baa5e76fc175b9e4497012d6d17591ca49c2e511fbe8"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/badaix/aixlog"
PKG_URL="https://github.com/badaix/aixlog/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Header-only C++ logging library."
PKG_BUILD_FLAGS="-sysroot"

PKG_CMAKE_OPTS_TARGET="-DBUILD_EXAMPLE=OFF"
