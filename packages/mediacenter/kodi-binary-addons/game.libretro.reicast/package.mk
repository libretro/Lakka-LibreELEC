# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.reicast"
PKG_VERSION="e07dddca2530c8916b0447397d5223bb9118a729"
PKG_SHA256="69b2d5a83b8616e348be3828cf52fbf328c279ebb6d9c767edbc79b47f24a371"
PKG_REV="111"
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
