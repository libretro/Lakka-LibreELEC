# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="tinyxml2"
PKG_VERSION="8.0.0"
PKG_SHA256="6ce574fbb46751842d23089485ae73d3db12c1b6639cda7721bf3a7ee862012c"
PKG_LICENSE="zlib"
PKG_SITE="http://www.grinninglizard.com/tinyxml2/index.html"
PKG_URL="https://github.com/leethomason/tinyxml2/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="TinyXML2 is a simple, small, C++ XML parser."

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=OFF \
                       -DBUILD_TESTING=OFF \
                       -DCMAKE_BUILD_TYPE=Release"

