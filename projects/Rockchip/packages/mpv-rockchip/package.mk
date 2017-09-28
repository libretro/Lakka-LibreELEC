################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017 Team LibreELEC
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

PKG_NAME="mpv-rockchip"
PKG_VERSION="rockchip"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://mpv.io/"
PKG_URL="https://github.com/LongChair/mpv/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="mpv-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain ffmpeg-rockchip libass libdrm alsa rkmpp $OPENGLES"
PKG_SECTION="multimedia"
PKG_SHORTDESC="mpv: Video player based on MPlayer/mplayer2"
PKG_LONGDESC="mpv: mpv is a media player based on MPlayer and mplayer2. It supports a wide variety of video file formats, audio and video codecs, and subtitle types."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="--disable-libsmbclient --disable-apple-remote --prefix=/usr --enable-rkmpp --enable-drm --enable-gbm --enable-egl-drm"

if [ "$PULSEAUDIO_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET pulseaudio"
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --enable-pulse"
else
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --disable-pulse"
fi

if [ "$KODI_BLURAY_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libbluray"
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --enable-libbluray"
else
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --disable-libbluray"
fi

unpack() {
  rm -rf $BUILD/$PKG_NAME-$PKG_VERSION
  git clone --depth 1 --branch $PKG_VERSION https://github.com/LongChair/mpv.git $BUILD/$PKG_NAME-$PKG_VERSION
}

configure_target() {
  cd $PKG_BUILD
    ./bootstrap.py
    ./waf configure $PKG_CONFIGURE_OPTS_TARGET
}

make_target() {
  cd $PKG_BUILD
    ./waf build
}

makeinstall_target() {
  cd $PKG_BUILD
    ./waf install --destdir=$INSTALL
}
