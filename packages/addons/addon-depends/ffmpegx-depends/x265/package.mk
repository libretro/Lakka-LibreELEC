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

PKG_NAME="x265"
PKG_VERSION="2.8"
PKG_SHA256="fbd8a89b4a1391c6b504b91b69df440e3ef14afc8fddfcc209281c9159d83a86"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/videolan/x265"
PKG_URL="https://github.com/videolan/x265/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="multimedia"
PKG_LONGDESC="x265 is a H.265/HEVC video encoder application library"
PKG_TOOLCHAIN="make"

pre_configure_target() {
  LDFLAGS="$LDFLAGS -ldl"
  cmake -G "Unix Makefiles" ./source
}
