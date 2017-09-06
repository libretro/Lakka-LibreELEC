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

PKG_NAME="game.libretro.vecx"
PKG_VERSION="becb728"
PKG_SHA256="4eac3ba1962e55187d160fea882e58536d709a2ecff725533e42ab895f4beb6a"
PKG_REV="103"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kodi-game/game.libretro.vecx"
PKG_URL="https://github.com/kodi-game/game.libretro.vecx/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform libretro-vecx"
PKG_SECTION=""
PKG_SHORTDESC="game.libretro.vecx: vecx for Kodi"
PKG_LONGDESC="game.libretro.vecx: vecx for Kodi"
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
