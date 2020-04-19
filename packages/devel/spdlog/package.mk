# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="spdlog"
PKG_VERSION="1.5.0"
PKG_SHA256="b38e0bbef7faac2b82fed550a0c19b0d4e7f6737d5321d4fd8f216b80f8aee8a"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/gabime/spdlog"
PKG_URL="https://github.com/gabime/spdlog/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libfmt"
PKG_LONGDESC="Very fast, header only, C++ logging library."
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DCMAKE_CXX_STANDARD=14 -DCMAKE_CXX_EXTENSIONS:BOOL=OFF -DSPDLOG_FMT_EXTERNAL=ON -DSPDLOG_BUILD_EXAMPLE=OFF -DSPDLOG_BUILD_TESTS=OFF"
