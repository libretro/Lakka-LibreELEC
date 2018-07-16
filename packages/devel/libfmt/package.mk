# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libfmt"
PKG_VERSION="3.0.2"
PKG_SHA256="fa4a062897b2f3712badfdb8583e6d938252e1156cb5705c3af87705dfef3957"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/fmtlib/fmt"
PKG_URL="https://github.com/fmtlib/fmt/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="fmt-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="devel"
PKG_SHORTDESC="fmt is an open-source formatting library for C++. It can be used as a safe alternative to printf or as a fast alternative to IOStreams."
PKG_LONGDESC="fmt is an open-source formatting library for C++. It can be used as a safe alternative to printf or as a fast alternative to IOStreams."

PKG_CMAKE_OPTS_TARGET="-DFMT_DOC=OFF -DFMT_INSTALL=ON -DFMT_TEST=OFF -DFMT_USE_CPP11=ON"
