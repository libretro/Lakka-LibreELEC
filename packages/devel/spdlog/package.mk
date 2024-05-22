# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="spdlog"
PKG_VERSION="1.14.1"
PKG_SHA256="1586508029a7d0670dfcb2d97575dcdc242d3868a259742b69f100801ab4e16b"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/gabime/spdlog"
PKG_URL="https://github.com/gabime/spdlog/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libfmt"
PKG_LONGDESC="Very fast, header only, C++ logging library."

PKG_CMAKE_OPTS_TARGET="-DCMAKE_CXX_STANDARD=14 \
                       -DCMAKE_CXX_EXTENSIONS:BOOL=OFF \
                       -DSPDLOG_BUILD_SHARED=ON \
                       -DSPDLOG_FMT_EXTERNAL=ON \
                       -DSPDLOG_BUILD_EXAMPLE=OFF \
                       -DSPDLOG_BUILD_TESTS=OFF"
