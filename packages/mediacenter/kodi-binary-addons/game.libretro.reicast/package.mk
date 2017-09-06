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

PKG_NAME="game.libretro.reicast"
PKG_VERSION="e2c03e9"
PKG_SHA256="1207b9f71f1fef6c5bea1cabf3edef7c87e80e3445f9000836eebbb87d2c8e7e"
PKG_REV="103"
# no openGL suport in retroplayer yet
PKG_ARCH="none"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kodi-game/game.libretro.reicast"
PKG_URL="https://github.com/kodi-game/game.libretro.reicast/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform libretro-reicast"
PKG_SECTION=""
PKG_SHORTDESC="game.libretro.reicast: reicast for kodi"
PKG_LONGDESC="game.libretro.reicast: reicast for Kodi"
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
