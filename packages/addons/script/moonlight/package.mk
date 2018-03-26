################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
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

PKG_NAME="moonlight"
PKG_VERSION="4d94439"
PKG_SHA256="5190f9c3a0fd17c7c8f0de8c2509f4749a2f399b7dc4d1402dd55c6f351260b2"
PKG_VERSION_NUMBER="2.2.2"
PKG_REV="109"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/dead/script.moonlight"
PKG_URL="https://github.com/dead/script.moonlight/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="script.moonlight-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain moonlight-embedded"
PKG_SECTION="script"
PKG_SHORTDESC="Moonlight: implementation of NVIDIA's GameStream protocol"
PKG_LONGDESC="Moonlight ($PKG_VERSION_NUMBER): allows you to stream your collection of games from your PC (with NVIDIA Gamestream) to your device and play them remotely"
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Moonlight"
PKG_ADDON_TYPE="xbmc.service.pluginsource"
PKG_ADDON_PROVIDES="executable"

post_unpack() {
  # don't use the files from the script
  rm $PKG_BUILD/script.moonlight/icon.png
  rm $PKG_BUILD/script.moonlight/changelog.txt
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID
    cp -PR $PKG_BUILD/script.moonlight/* $ADDON_BUILD/$PKG_ADDON_ID

    # use our own changelog.txt
    cp $PKG_DIR/changelog.txt $ADDON_BUILD/$PKG_ADDON_ID

    # let's use our addon.xml instead
    rm $ADDON_BUILD/$PKG_ADDON_ID/addon.xml

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir moonlight-embedded)/.$TARGET_NAME/moonlight $ADDON_BUILD/$PKG_ADDON_ID/bin

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/lib
    cp $(get_build_dir moonlight-embedded)/.$TARGET_NAME/libgamestream/libgamestream.so.2.4.6 $ADDON_BUILD/$PKG_ADDON_ID/lib
    cp $(get_build_dir moonlight-embedded)/.$TARGET_NAME/libgamestream/libmoonlight-common.so.2.4.6 $ADDON_BUILD/$PKG_ADDON_ID/lib

    if [ "$KODIPLAYER_DRIVER" = "bcm2835-driver" ]; then
      cp -P $(get_build_dir moonlight-embedded)/.$TARGET_NAME/libmoonlight-pi.so $ADDON_BUILD/$PKG_ADDON_ID/lib
    elif [ "$KODIPLAYER_DRIVER" = "libamcodec" ]; then
      cp -P $(get_build_dir moonlight-embedded)/.$TARGET_NAME/libmoonlight-aml.so $ADDON_BUILD/$PKG_ADDON_ID/lib
    fi

    cp $(get_build_dir libevdev)/.install_pkg/usr/lib/libevdev.so.2 $ADDON_BUILD/$PKG_ADDON_ID/lib

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/etc
    cp -P $(get_build_dir moonlight-embedded)/moonlight.conf $ADDON_BUILD/$PKG_ADDON_ID/etc
    cp -P $(get_build_dir moonlight-embedded)/gamecontrollerdb.txt $ADDON_BUILD/$PKG_ADDON_ID/etc
}
