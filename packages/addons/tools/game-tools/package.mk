# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game-tools"
PKG_VERSION=""
PKG_REV="101"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="virtual"
PKG_SHORTDESC="A bundle of game tools and programs"
PKG_LONGDESC="This bundle currently includes bchunk, ecm-tools, iat, and linuxconsoletools"

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
}
