# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.pcsx-rearmed"
PKG_VERSION="75208998eb366f70624d427d14353662b07990a2"
PKG_SHA256="5d99e36d62f1016ebff01a6877a48aa8b01a9c0b88f5c5dd67c0dd710d5ff352"
PKG_REV="108"
# neon optimizations make it only useful for arm
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kodi-game/game.libretro.pcsx-rearmed"
PKG_URL="https://github.com/kodi-game/game.libretro.pcsx-rearmed/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform libretro-pcsx-rearmed"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.pcsx-rearmed: PCSX Rearmed for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"

if ! target_has_feature neon; then
  echo "${DEVICE:-${PROJECT}} doesn't support neon"
  exit 0
fi
