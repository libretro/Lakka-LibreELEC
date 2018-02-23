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

PKG_NAME="ffmpegx"
PKG_VERSION="3.4.2"
PKG_SHA256="d079c68dc19a0223239a152ffc2b67ef1e9d3144e4d2c2563380dc59dccf33e5"
PKG_ARCH="any"
PKG_LICENSE="LGPLv2.1+"
PKG_SITE="https://ffmpeg.org"
PKG_URL="https://github.com/FFmpeg/FFmpeg/archive/n${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR="FFmpeg-n${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain bzip2 fdk-aac libvorbis openssl opus x264 x265 zlib"
PKG_SECTION="multimedia"
PKG_LONGDESC="FFmpegx is an complete FFmpeg build to support encoding and decoding"
# ffmpeg builds better with these options
PKG_BUILD_FLAGS="-gold -lto"

# Dependencies
get_graphicdrivers

if [ "$KODIPLAYER_DRIVER" == "bcm2835-driver" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET bcm2835-driver"
fi

if [[ ! $TARGET_ARCH = arm ]] || target_has_feature neon; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libvpx"
fi

# X11 grab for screen recording
if [ "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libxcb libX11"
fi

pre_configure_target() {
  cd $PKG_BUILD
  rm -rf .$TARGET_NAME

  if [ "$KODIPLAYER_DRIVER" == "bcm2835-driver" ]; then
    CFLAGS="-DRPI=1 -I$SYSROOT_PREFIX/usr/include/IL -I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads -I$SYSROOT_PREFIX/usr/include/interface/vmcs_host/linux $CFLAGS"
    PKG_FFMPEG_LIBS="-lbcm_host -ldl -lmmal -lmmal_core -lmmal_util -lvchiq_arm -lvcos -lvcsm"
  fi

  if [ "$TARGET_ARCH" == "arm" ]; then
    PKG_FFMPEG_ARM_AO="--enable-hardcoded-tables"
  fi

# HW encoders

  # RPi 0-3
  if [ "$KODIPLAYER_DRIVER" == "bcm2835-driver" ]; then
    PKG_FFMPEG_HW_ENCODERS_RPi="\
    `#Video encoders` \
    --enable-omx-rpi \
    --enable-mmal \
    --enable-encoder=h264_omx \
    \
    `#Video hwaccel` \
    --enable-hwaccel=h264_mmal \
    --enable-hwaccel=mpeg2_mmal \
    --enable-hwaccel=mpeg4_mmal \
    --enable-hwaccel=vc1_mmal"
  fi

  # Generic
  if [[ "$TARGET_ARCH" = "x86_64" ]]; then
    PKG_FFMPEG_HW_ENCODERS_GENERIC="\
    `#Video encoders` \
    --enable-encoder=h264_nvenc \
    --enable-encoder=h264_vaapi \
    --enable-encoder=hevc_nvenc \
    --enable-encoder=hevc_vaapi \
    --enable-encoder=mjpeg_vaapi \
    --enable-encoder=mpeg2_vaapi \
    --enable-encoder=vp8_vaapi \
    --enable-encoder=vp9_vaapi \
    \
    `#Video hwaccel` \
    --enable-hwaccel=h263_vaapi \
    --enable-hwaccel=h264_vaapi \
    --enable-hwaccel=hevc_vaapi \
    --enable-hwaccel=mpeg2_vaapi \
    --enable-hwaccel=mpeg4_vaapi \
    --enable-hwaccel=vc1_vaapi \
    --enable-hwaccel=vp9_vaapi \
    --enable-hwaccel=wmv3_vaapi"
  fi

# Encoders
    PKG_FFMPEG_ENCODERS="\
    `#Video encoders` \
    --enable-libvpx \
    --enable-encoder=libvpx_vp8 \
    --enable-encoder=libvpx_vp9 \
    --enable-libx264 \
    --enable-encoder=x264 \
    --enable-libx265 \
    --enable-encoder=x265 \
    \
    `#Audio encoders` \
    --enable-encoder=ac3 \
    --enable-encoder=eac3 \
    --enable-libfdk-aac \
    --enable-encoder=libfdk-aac \
    --enable-encoder=flac \
    --enable-libmp3lame \
    --enable-encoder=libmp3lame \
    --enable-libopus \
    --enable-encoder=libopus \
    --enable-libvorbis \
    --enable-encoder=libvorbis"

# X11 grab for screen recording
  if [ "$DISPLAYSERVER" = "x11" ]; then
    PKG_FFMPEG_LIBS="$PKG_FFMPEG_LIBS -lX11"
    PKG_FFMPEG_X11_GRAB="\
    --enable-libxcb \
    --enable-libxcb-shm \
    --enable-libxcb-xfixes \
    --enable-libxcb-shape"
  fi
}

configure_target() {
  ./configure \
    \
    `#Programs to build` \
    --enable-ffmpeg \
    --disable-ffplay \
    --enable-ffprobe \
    --disable-ffserver \
    \
    `#Static and Shared` \
    --enable-static \
    --disable-shared \
    \
    `#Licensing options` \
    --enable-gpl \
    --enable-nonfree \
    \
    `#Documentation options` \
    --disable-doc \
    \
    `#Hardware accelerated decoding encoding` \
    $PKG_FFMPEG_HW_ENCODERS_RPi \
    $PKG_FFMPEG_HW_ENCODERS_GENERIC \
    \
    `#General options` \
    --enable-avresample \
    --disable-lzma \
    --disable-alsa \
    $PKG_FFMPEG_X11_GRAB \
    \
    `#Toolchain options` \
    --arch="$TARGET_ARCH" \
    --cpu="$TARGET_CPU" \
    --cross-prefix="$TARGET_PREFIX" \
    --enable-cross-compile \
    --sysroot="$SYSROOT_PREFIX" \
    --sysinclude="$SYSROOT_PREFIX/usr/include" \
    --target-os="linux" \
    --nm="$NM" \
    --ar="$AR" \
    --as="$CC" \
    --cc="$CC" \
    --ld="$CC" \
    --pkg-config="$TOOLCHAIN/bin/pkg-config" \
    --host-cc="$HOST_CC" \
    --host-cflags="$HOST_CFLAGS" \
    --host-ldflags="$HOST_LDFLAGS" \
    --host-extralibs="-lm" \
    --extra-cflags="$CFLAGS" \
    --extra-ldflags="$LDFLAGS" \
    --extra-libs="$PKG_FFMPEG_LIBS" \
    --extra-version="x" \
    --enable-pic \
    --enable-openssl \
    \
    `#Advanced options` \
    $PKG_FFMPEG_ARM_AO \

}

makeinstall_target() {
  make install DESTDIR="$INSTALL/../.INSTALL_PKG"
}

post_makeinstall_target() {
  for ff in "$INSTALL/../.INSTALL_PKG/usr/local/bin/"*; do mv "$ff" "${ff}x"; done
}
