################################################################################
#      This file is part of LibreELEC - http://www.libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
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
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://he.fi/bchunk/"
PKG_URL="http://he.fi/bchunk/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="system"
PKG_SHORTDESC="binchunker converts a CD image in a .bin / .cue format (sometimes .raw / .cue) to a set of .iso and .cdr tracks"
PKG_LONGDESC="binchunker converts a CD image in a .bin / .cue format (sometimes .raw / .cue) to a set of .iso and .cdr tracks"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

makeinstall_target() {
  :
}
