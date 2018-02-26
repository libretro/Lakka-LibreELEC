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

PKG_NAME="emby"
PKG_VERSION="3.3.0.0"
PKG_SHA256="15ca0835d939dbd2ac730bafa1377276c3a63854fd6a2ace8ff02dd439cdd692"
PKG_REV="118"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://emby.media"
PKG_URL="https://github.com/MediaBrowser/Emby/releases/download/$PKG_VERSION/Emby.Mono.zip"
PKG_DEPENDS_TARGET="toolchain imagemagick"
PKG_SECTION="service"
PKG_SHORTDESC="Emby Server: a personal media server"
PKG_LONGDESC="Emby Server ($PKG_VERSION) brings your home videos, music, and photos together, automatically converting and streaming your media on-the-fly to any device"
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Emby Server"
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_REQUIRES="tools.ffmpeg-tools:0.0.0 tools.mono:0.0.0"
PKG_MAINTAINER="Anton Voyl (awiouy)"

unpack() {
  mkdir -p $PKG_BUILD
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/Emby.Mono
  unzip -q $SOURCES/$PKG_NAME/$PKG_SOURCE_NAME \
        -d $ADDON_BUILD/$PKG_ADDON_ID/Emby.Mono

  sed -i 's/libMagickWand-6./libMagickWand-7./g' \
      $ADDON_BUILD/$PKG_ADDON_ID/Emby.Mono/ImageMagickSharp.dll.config

  sed -i 's/libsqlite3.so/libsqlite3.so.0/g' \
      $ADDON_BUILD/$PKG_ADDON_ID/Emby.Mono/SQLitePCLRaw.provider.sqlite3.dll.config

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/lib
  cp -L $(get_build_dir imagemagick)/.install_pkg/usr/lib/libMagickCore-7.Q8.so.? \
        $(get_build_dir imagemagick)/.install_pkg/usr/lib/libMagickWand-7.Q8.so   \
        $ADDON_BUILD/$PKG_ADDON_ID/lib/
}
