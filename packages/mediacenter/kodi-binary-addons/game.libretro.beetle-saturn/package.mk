# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.beetle-saturn"
PKG_VERSION="986193925d6f3508d4cdf68fb15e9e6177106535"
PKG_SHA256="6de55c6c5c29dfdc3bf3a2638c7dd5ea696b8291558b9c22446e839e31090d53"
PKG_REV="108"
# no openGL suport in retroplayer yet
PKG_ARCH="none"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kodi-game/game.libretro.beetle-saturn"
PKG_URL="https://github.com/kodi-game/game.libretro.beetle-saturn/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform libretro-beetle-saturn"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.beetle-saturn: beetle-saturn for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
