# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="jsoncpp"
PKG_VERSION="1.9.4"
PKG_SHA256="e34a628a8142643b976c7233ef381457efad79468c67cb1ae0b83a33d7493999"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/open-source-parsers/jsoncpp/"
PKG_URL="https://github.com/open-source-parsers/jsoncpp/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A C++ library for interacting with JSON."
PKG_TOOLCHAIN="cmake"
PKG_BUILD_FLAGS="+pic"

PKG_CMAKE_OPTS_TARGET="-DJSONCPP_WITH_TESTS=OFF \
                       -DJSONCPP_WITH_EXAMPLE=OFF \
                       -DBUILD_SHARED_LIBS=OFF \
                       -DBUILD_STATIC_LIBS=ON \
                       -DBUILD_OBJECT_LIBS=OFF"
