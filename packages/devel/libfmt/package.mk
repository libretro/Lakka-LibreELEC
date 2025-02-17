# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libfmt"
PKG_VERSION="10.2.1"
PKG_SHA256="1250e4cc58bf06ee631567523f48848dc4596133e163f02615c97f78bab6c811"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/fmtlib/fmt"
PKG_URL="https://github.com/fmtlib/fmt/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="fmt is an open-source formatting library for C++. It can be used as a safe alternative to printf or as a fast alternative to IOStreams."

PKG_CMAKE_OPTS_TARGET="-DCMAKE_CXX_STANDARD=14 \
                       -DCMAKE_CXX_EXTENSIONS:BOOL=OFF \
                       -DFMT_DOC=OFF \
                       -DFMT_INSTALL=ON \
                       -DFMT_TEST=OFF \
                       -DBUILD_SHARED_LIBS=ON"

if [ "${DISTRO}" = "Lakka" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE"
fi
