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

PKG_NAME="bchunk"
PKG_VERSION="1.2.0"
PKG_SHA256="afdc9d5e38bdd16f0b8b9d9d382b0faee0b1e0494446d686a08b256446f78b5d"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://he.fi/bchunk/"
PKG_URL="http://he.fi/bchunk/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="system"
PKG_SHORTDESC="binchunker converts a CD image in a .bin / .cue format (sometimes .raw / .cue) to a set of .iso and .cdr tracks"
PKG_LONGDESC="binchunker converts a CD image in a .bin / .cue format (sometimes .raw / .cue) to a set of .iso and .cdr tracks"
PKG_AUTORECONF="no"

makeinstall_target() {
  :
}
