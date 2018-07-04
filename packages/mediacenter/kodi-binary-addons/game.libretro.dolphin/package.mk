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

PKG_NAME="game.libretro.dolphin"
PKG_VERSION="f73b307"
PKG_SHA256="039cfecbfe67c24e87708008f811538b7d4502aa2171379570ee2632a33effe6"
PKG_REV="105"
# no openGL suport in retroplayer yet
PKG_ARCH="none"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kodi-game/game.libretro.dolphin"
PKG_URL="https://github.com/kodi-game/game.libretro.dolphin/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform libretro-dolphin"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.dolphin: Dolphin for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
