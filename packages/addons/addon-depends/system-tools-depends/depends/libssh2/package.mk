################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2018-present Team LibreELEC
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

PKG_NAME="libssh2"
PKG_VERSION="1.8.0"
PKG_SHA256="39f34e2f6835f4b992cafe8625073a88e5a28ba78f83e8099610a7b3af4676d4"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="https://www.libssh2.org"
PKG_URL="https://www.libssh2.org/download/libssh2-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain openssl"
PKG_SECTION="libs"
PKG_LONGDESC="A library implementing the SSH2 protocol"

PKG_CMAKE_OPTS_TARGET="-DBUILD_EXAMPLES=OFF \
                       -DBUILD_TESTING=OFF"
