# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mpv-drmprime"
PKG_VERSION="0.29.1"
PKG_SHA256="f9f9d461d1990f9728660b4ccb0e8cb5dce29ccaa6af567bec481b79291ca623"
PKG_LICENSE="GPL"
PKG_SITE="https://mpv.io/"
PKG_URL="https://github.com/mpv-player/mpv/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain waf:host alsa ffmpeg libass libdrm"
PKG_LONGDESC="A media player based on MPlayer and mplayer2. It supports a wide variety of video file formats, audio and video codecs, and subtitle types."
PKG_TOOLCHAIN="manual"

PKG_CONFIGURE_OPTS_TARGET="--prefix=/usr \
                           --disable-libsmbclient \
                           --disable-apple-remote \
                           --disable-libarchive \
                           --disable-lua \
                           --disable-javascript \
                           --disable-uchardet \
                           --disable-rubberband \
                           --disable-lcms2 \
                           --disable-vapoursynth \
                           --disable-jack \
                           --disable-wayland \
                           --disable-x11 \
                           --disable-vulkan \
                           --disable-caca \
                           --disable-crossc \
                           --disable-libv4l2 \
                           --enable-drm \
                           --enable-drmprime \
                           --enable-gbm \
                           --enable-egl-drm"

if [ "$OPENGLES_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" $OPENGLES"
fi

if [ "$OPENGL_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" $OPENGL"
fi

if [ "$VAAPI_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" libva"
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-vaapi --enable-vaapi-drm"
else
  PKG_CONFIGURE_OPTS_TARGET+=" --disable-vaapi"
fi

if [ "$PULSEAUDIO_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" pulseaudio"
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-pulse"
else
  PKG_CONFIGURE_OPTS_TARGET+=" --disable-pulse"
fi

if [ "$KODI_BLURAY_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" libbluray"
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-libbluray"
else
  PKG_CONFIGURE_OPTS_TARGET+=" --disable-libbluray"
fi

configure_target() {
  waf configure $PKG_CONFIGURE_OPTS_TARGET
}

make_target() {
  waf build
}

makeinstall_target() {
  waf install --destdir=$INSTALL
  rm -r $INSTALL/usr/share
}
