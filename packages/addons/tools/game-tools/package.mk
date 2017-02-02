################################################################################
#      This file is part of LibreELEC - http://www.libreelec.tv
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

PKG_NAME="game-tools"
PKG_VERSION=""
PKG_REV="100"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="virtual"
PKG_SHORTDESC="A bundle of game tools and programs"
PKG_LONGDESC="This bundle currently includes bchunk, ecm-tools, iat, and linuxconsoletools"
PKG_AUTORECONF="no"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Game Tools"
PKG_ADDON_TYPE="xbmc.python.script"

PKG_DEPENDS_TARGET="toolchain \
                    bchunk \
                    ecm-tools \
                    iat \
                    linuxconsoletools"

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin/
    # bchunk
    cp -P $(get_build_dir bchunk)/bchunk $ADDON_BUILD/$PKG_ADDON_ID/bin

    # ecm-tools
    cp -P $(get_build_dir ecm-tools)/bin2ecm $ADDON_BUILD/$PKG_ADDON_ID/bin
    ln -s bin2ecm $ADDON_BUILD/$PKG_ADDON_ID/bin/ecm2bin

    # iat
    cp -P $(get_build_dir iat)/.$TARGET_NAME/src/iat $ADDON_BUILD/$PKG_ADDON_ID/bin

    # linuxconsoletools
    cp -P $(get_build_dir linuxconsoletools)/utils/fftest $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir linuxconsoletools)/utils/jscal $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir linuxconsoletools)/utils/jstest $ADDON_BUILD/$PKG_ADDON_ID/bin

  debug_strip $ADDON_BUILD/$PKG_ADDON_ID/bin
}
