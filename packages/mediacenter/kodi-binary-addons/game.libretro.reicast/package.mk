# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

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
