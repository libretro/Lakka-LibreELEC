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

PKG_NAME="zstd"
PKG_VERSION="1.3.2"
PKG_SHA256="ac5054a3c64e6510bc1ae890d05e3d271cc33ceebc9d06ac9f08105766d2798a"
PKG_ARCH="any"
PKG_LICENSE="BSD/GPLv2"
PKG_SITE="http://www.zstd.net"
PKG_URL="https://github.com/facebook/zstd/archive/v${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR=$PKG_NAME-$PKG_VERSION
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="compress"
PKG_SHORTDESC="fast real-time compression algorithm"

PKG_AUTORECONF="no"

PKG_CMAKE_SCRIPT="$PKG_BUILD/build/cmake/CMakeLists.txt"
PKG_CMAKE_OPTS_HOST="-DTHREADS_PTHREAD_ARG=0"
