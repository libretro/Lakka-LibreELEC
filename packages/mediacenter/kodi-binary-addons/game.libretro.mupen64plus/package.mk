# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.mupen64plus"
PKG_VERSION="73727c7babd7481d1da40c7444f8452c07ea2584"
PKG_SHA256="dc39b5f9466818f6f3455957f2a5b433d77df4341c94b029344f8d2c33d33b65"
PKG_REV="109"
# no openGL suport in retroplayer yet
PKG_ARCH="none"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kodi-game/game.libretro.mupen64plus"
PKG_URL="https://github.com/kodi-game/game.libretro.mupen64plus/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform libretro-mupen64plus"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.mupen64plus: Mupen 64 Plus emulator for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
