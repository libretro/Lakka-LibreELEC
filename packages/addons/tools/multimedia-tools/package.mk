################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
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

PKG_NAME="multimedia-tools"
PKG_VERSION=""
PKG_REV="104"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="virtual"
PKG_SHORTDESC="A bundle of multimedia tools and programs"
PKG_LONGDESC="This bundle currently includes alsamixer, mediainfo, mesa-demos, mpg123, opencaster, squeezelite, tsdecrypt and tstools."

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Multimedia Tools"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_ADDON_PROVIDES=""

PKG_AUTORECONF="no"

PKG_DEPENDS_TARGET="toolchain \
                    alsa-utils \
                    mediainfo \
                    mesa-demos \
                    mpg123 \
                    opencaster \
                    squeezelite \
                    tsdecrypt \
                    tstools"

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin/
    # alsamixer
    cp -P $(get_build_dir alsa-utils)/.$TARGET_NAME/alsamixer/alsamixer $ADDON_BUILD/$PKG_ADDON_ID/bin/

    # mediainfo
    cp -P $(get_build_dir mediainfo)/Project/GNU/CLI/mediainfo $ADDON_BUILD/$PKG_ADDON_ID/bin

    # mesa-demos
    cp -P $(get_build_dir mesa-demos)/.$TARGET_NAME/src/xdemos/glxdemo $ADDON_BUILD/$PKG_ADDON_ID/bin 2>/dev/null || :
    cp -P $(get_build_dir mesa-demos)/.$TARGET_NAME/src/xdemos/glxgears $ADDON_BUILD/$PKG_ADDON_ID/bin 2>/dev/null || :
    cp -P $(get_build_dir mesa-demos)/.$TARGET_NAME/src/xdemos/glxinfo $ADDON_BUILD/$PKG_ADDON_ID/bin 2>/dev/null || :

    # mpg123
    cp -P $(get_build_dir mpg123)/.install_pkg/usr/bin/* $ADDON_BUILD/$PKG_ADDON_ID/bin/

    # opencaster
    cp -P $(get_build_dir opencaster)/.install_pkg/* $ADDON_BUILD/$PKG_ADDON_ID/bin/

    # squeezelite
    cp -P $(get_build_dir squeezelite)/squeezelite $ADDON_BUILD/$PKG_ADDON_ID/bin/

    # tsdecrypt
    cp -P $(get_build_dir tsdecrypt)/tsdecrypt $ADDON_BUILD/$PKG_ADDON_ID/bin

    # tstools
    cp -P $(get_build_dir tstools)/bin/* $ADDON_BUILD/$PKG_ADDON_ID/bin/

  debug_strip $ADDON_BUILD/$PKG_ADDON_ID/bin
}
