################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2018-present Team LibreELEC
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

PKG_NAME="ffmpeg-tools"
PKG_VERSION="1.0"
PKG_REV="100"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://libreelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain ffmpegx"
PKG_SECTION="tools"
PKG_SHORTDESC="FFmpeg binary for transcoding and audio/video manipulating."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="FFmpeg Tools"
PKG_ADDON_TYPE="xbmc.python.script"

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin/
  cp -L $(get_build_dir ffmpegx)/.INSTALL_PKG/usr/local/bin/* $ADDON_BUILD/$PKG_ADDON_ID/bin
}
