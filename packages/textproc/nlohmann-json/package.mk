# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="nlohmann-json"
PKG_VERSION="3.7.3"
PKG_SHA256="249548f4867417d66ae46b338dfe0a2805f3323e81c9e9b83c89f3adbfde6f31"
PKG_LICENSE="MIT"
PKG_SITE="https://nlohmann.github.io/json/"
PKG_URL="https://github.com/nlohmann/json/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="JSON for Modern C++"
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DBUILD_TESTING:BOOL=OFF"
