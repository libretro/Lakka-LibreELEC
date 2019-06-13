# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="jsoncpp"
PKG_VERSION="1.8.4"
PKG_SHA256="c49deac9e0933bcb7044f08516861a2d560988540b23de2ac1ad443b219afdb6"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/open-source-parsers/jsoncpp/"
PKG_URL="https://github.com/open-source-parsers/jsoncpp/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A C++ library for interacting with JSON."
PKG_TOOLCHAIN="cmake"
PKG_BUILD_FLAGS="+pic"

PKG_CMAKE_OPTS_TARGET="-DJSONCPP_WITH_TESTS=OFF"
