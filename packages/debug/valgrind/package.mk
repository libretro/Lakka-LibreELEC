################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
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

PKG_NAME="valgrind"
PKG_VERSION="3.13.0"
PKG_SHA256="d76680ef03f00cd5e970bbdcd4e57fb1f6df7d2e2c071635ef2be74790190c3b"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://valgrind.org/"
PKG_URL="ftp://sourceware.org/pub/valgrind/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="debug"
PKG_SHORTDESC="A tool to help find memory-management problems in programs"
PKG_LONGDESC="A tool to help find memory-management problems in programs"
PKG_BUILD_FLAGS="-lto"

if [ "$TARGET_ARCH" = "arm" ]; then
  PKG_CONFIGURE_OPTS_TARGET="--enable-only32bit"
elif [ "$TARGET_ARCH" = "aarch64" -o "$TARGET_ARCH" = "x86_64" ]; then
  PKG_CONFIGURE_OPTS_TARGET="--enable-only64bit"
fi
