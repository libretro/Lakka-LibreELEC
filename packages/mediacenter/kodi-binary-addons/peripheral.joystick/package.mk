# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="peripheral.joystick"
PKG_VERSION="20.1.15-Nexus"
PKG_SHA256="7292431b26e3ea969967a02f42ce48cae7742398b148ca041470c17934d06272"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/xbmc/peripheral.joystick"
PKG_URL="https://github.com/xbmc/peripheral.joystick/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform p8-platform systemd"
PKG_SECTION=""
PKG_SHORTDESC="peripheral.joystick: Joystick support in Kodi"
PKG_LONGDESC="peripheral.joystick provides joystick support and button mapping"
PKG_BUILD_FLAGS="+lto"

PKG_IS_ADDON="embedded"
PKG_ADDON_TYPE="kodi.peripheral"

post_install() {
  if [ "${PROJECT}" = "L4T" -a "${DEVICE}" = "Switch" ]; then
    # Set UDEV controller driver as active
    sed -i -e 's|<default>0</default>|<default>1</default>|' ${INSTALL}/usr/share/kodi/addons/peripheral.joystick/resources/settings.xml
  fi
}
