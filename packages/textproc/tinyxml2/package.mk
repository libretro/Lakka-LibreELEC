# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="tinyxml2"
PKG_VERSION="7.1.0"
PKG_SHA256="68ebd396a4220d5a9b5a621c6e9c66349c5cfdf5efaea3f16e3bb92e45f4e2a3"
PKG_LICENSE="zlib"
PKG_SITE="http://www.grinninglizard.com/tinyxml2/index.html"
PKG_URL="https://github.com/leethomason/tinyxml2/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="TinyXML2 is a simple, small, C++ XML parser."

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=OFF \
                       -DBUILD_TESTING=OFF \
                       -DCMAKE_BUILD_TYPE=Release"

