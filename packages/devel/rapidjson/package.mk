################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017-present Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="rapidjson"
PKG_VERSION="1.1.0"
PKG_SHA256="bf7ced29704a1e696fbccf2a2b4ea068e7774fa37f6d7dd4039d0787f8bed98e"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/miloyip/rapidjson"
PKG_URL="https://github.com/miloyip/rapidjson/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="devel"
PKG_SHORTDESC="rapidjson: JSON parser/generator"
PKG_LONGDESC="A fast JSON parser/generator for C++ with both SAX/DOM style API"
PKG_AUTORECONF="no"

PKG_CMAKE_OPTS_TARGET="-DRAPIDJSON_BUILD_DOC=OFF \
                       -DRAPIDJSON_BUILD_EXAMPLES=OFF
                       -DRAPIDJSON_BUILD_TESTS=OFF \
                       -DRAPIDJSON_BUILD_THIRDPARTY_GTEST=OFF \
                       -DRAPIDJSON_BUILD_ASAN=OFF \
                       -DRAPIDJSON_BUILD_UBSAN=OFF \
                       -DRAPIDJSON_HAS_STDSTRING=ON"
