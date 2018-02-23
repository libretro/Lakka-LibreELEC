################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="jsoncpp"
PKG_VERSION="1.8.3"
PKG_SHA256="3671ba6051e0f30849942cc66d1798fdf0362d089343a83f704c09ee7156604f"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/open-source-parsers/jsoncpp/"
PKG_URL="https://github.com/open-source-parsers/jsoncpp/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="multimedia"
PKG_SHORTDESC="A C++ library for interacting with JSON."
PKG_LONGDESC="A C++ library for interacting with JSON."
PKG_TOOLCHAIN="cmake"
PKG_BUILD_FLAGS="+pic"

PKG_CMAKE_OPTS_TARGET="-DJSONCPP_WITH_TESTS=OFF"
