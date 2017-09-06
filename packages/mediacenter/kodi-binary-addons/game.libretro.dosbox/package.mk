################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
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

PKG_NAME="game.libretro.dosbox"
PKG_VERSION="d76ee2e"
PKG_SHA256="f73d9c71a4748ed74b1b75e4ecc13d7584c201fa12671c4000c762b57aa034af"
PKG_REV="103"
PKG_ARCH="none"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kodi-game/game.libretro.dosbox"
PKG_URL="https://github.com/kodi-game/game.libretro.dosbox/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform libretro-dosbox"
PKG_SECTION=""
PKG_SHORTDESC="game.libretro.dosbox: DOSBox for Kodi"
PKG_LONGDESC="game.libretro.dosbox: DOSBox for Kodi"
PKG_AUTORECONF="no"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"

configure_target() {
  cmake -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CONF \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_MODULE_PATH=$SYSROOT_PREFIX/usr/lib/kodi \
        -DCMAKE_PREFIX_PATH=$SYSROOT_PREFIX/usr \
        ..
}
