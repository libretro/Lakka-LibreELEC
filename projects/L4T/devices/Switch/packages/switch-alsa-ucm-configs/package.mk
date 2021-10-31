################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="switch-alsa-ucm-configs"
PKG_VERSION=""
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/lakkatv/Lakka"
PKG_URL=""
PKG_DEPENDS_TARGET="alsa-ucm-conf"
PKG_PRIORITY="optional"
PKG_SECTION="virtual"
PKG_SHORTDESC="Nintendo Switch Alsa UCM Configs"
PKG_LONGDESC=""

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

post_install() {
  mkdir -p "${INSTALL}"/usr/share/alsa/ucm2
  mkdir -p "${INSTALL}"/usr/share/alsa/init/postinit
  PWD="$(pwd)"
  cd "${INSTALL}"/usr/share/alsa/
  ln -s ucm2 ucm
  cd ${PWD}
  cp -Pr "${PKG_DIR}"/ucm_data/* "${INSTALL}"/usr/share/alsa/ucm/
  cp -Pr "${PKG_DIR}"/postinit/* "${INSTALL}"/usr/share/alsa/init/postinit/
  #Audio Fix Service
  enable_service alsa-init.service
}
