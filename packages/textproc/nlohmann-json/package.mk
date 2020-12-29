# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="nlohmann-json"
PKG_VERSION="3.9.1"
PKG_SHA256="4cf0df69731494668bdd6460ed8cb269b68de9c19ad8c27abc24cd72605b2d5b"
PKG_LICENSE="MIT"
PKG_SITE="https://nlohmann.github.io/json/"
PKG_URL="https://github.com/nlohmann/json/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="JSON for Modern C++"
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DBUILD_TESTING:BOOL=OFF"
