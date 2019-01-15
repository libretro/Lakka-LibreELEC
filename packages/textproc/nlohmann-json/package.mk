# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="nlohmann-json"
PKG_VERSION="3.5.0"
PKG_SHA256="e0b1fc6cc6ca05706cce99118a87aca5248bd9db3113e703023d23f044995c1d"
PKG_LICENSE="MIT"
PKG_SITE="https://nlohmann.github.io/json/"
PKG_URL="https://github.com/nlohmann/json/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="JSON for Modern C++"
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DBUILD_TESTING:BOOL=OFF"
