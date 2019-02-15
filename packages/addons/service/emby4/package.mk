# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="emby4"
PKG_VERSION="4.0.2.0"
PKG_SHA256="555e5646a6a70651876e0d61841d6a3365fd7f055ba7a1d2dcd93803c9915509"
PKG_REV="101"
PKG_ARCH="any"
PKG_LICENSE="prop."
PKG_SITE="http://emby.media"
PKG_URL="https://github.com/MediaBrowser/Emby.Releases/releases/download/$PKG_VERSION/embyserver-netcore_$PKG_VERSION.zip"
PKG_SOURCE_DIR="system"
PKG_DEPENDS_TARGET="toolchain imagemagick"
PKG_SECTION="service"
PKG_SHORTDESC="Emby Server: a personal media server"
PKG_LONGDESC="Emby Server ($PKG_VERSION) brings your home videos, music, and photos together, automatically converting and streaming your media on-the-fly to any device"
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Emby Server 4"
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_REQUIRES="tools.ffmpeg-tools:0.0.0 tools.dotnet-runtime:0.0.0"
PKG_MAINTAINER="Anton Voyl (awiouy)"

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/emby
  cp -r $PKG_BUILD/* \
        -d $ADDON_BUILD/$PKG_ADDON_ID/emby

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/lib
  cp -L $(get_build_dir imagemagick)/.install_pkg/usr/lib/libMagickCore-7.Q16HDRI.so.? \
        $ADDON_BUILD/$PKG_ADDON_ID/lib/
  cp -L $(get_build_dir imagemagick)/.install_pkg/usr/lib/libMagickWand-7.Q16HDRI.so \
        $ADDON_BUILD/$PKG_ADDON_ID/lib/CORE_RL_Wand_.so
}
