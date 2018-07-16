# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="kodi-theme-Estuary"
PKG_VERSION="1.0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kodi.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain kodi"
PKG_NEED_UNPACK="$(get_pkg_directory $MEDIACENTER)"
PKG_SECTION="mediacenter"
PKG_SHORTDESC="kodi-theme-Estuary: Kodi Mediacenter default theme"
PKG_LONGDESC="Kodi Media Center (which was formerly named Xbox Media Center and XBMC) is a free and open source cross-platform media player and home entertainment system software with a 10-foot user interface designed for the living-room TV. Its graphical user interface allows the user to easily manage video, photos, podcasts, and music from a computer, optical disk, local network, and the internet using a remote control."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/kodi/addons/
    cp -a $(get_build_dir kodi)/.$TARGET_NAME/addons/skin.estuary $INSTALL/usr/share/kodi/addons/
}
