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

PKG_NAME="game.libretro.reicast"
PKG_VERSION="5c0f1c6"
PKG_SHA256="cd8b21adfde0f04b052d6c06acff29c5c07f130e1764cfe937856a42f24e1d42"
PKG_REV="106"
# no openGL suport in retroplayer yet
PKG_ARCH="none"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kodi-game/game.libretro.reicast"
PKG_URL="https://github.com/kodi-game/game.libretro.reicast/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform libretro-reicast"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.reicast: reicast for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
