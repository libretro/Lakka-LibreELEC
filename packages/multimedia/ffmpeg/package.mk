################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="ffmpeg"
PKG_VERSION="xbmc-de69c91"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="http://ffmpeg.org"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain yasm:host zlib bzip2 libvorbis gnutls"
PKG_PRIORITY="optional"
PKG_SECTION="multimedia"
PKG_SHORTDESC="FFmpeg is a complete, cross-platform solution to record, convert and stream audio and video."
PKG_LONGDESC="FFmpeg is a complete, cross-platform solution to record, convert and stream audio and video."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$VAAPI" = yes ]; then
# configure GPU drivers and dependencies:
  get_graphicdrivers

  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $LIBVA"
  FFMPEG_VAAPI="--enable-vaapi"
else
  FFMPEG_VAAPI="--disable-vaapi"
fi

if [ "$VDPAU" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libvdpau"
  FFMPEG_VDPAU="--enable-vdpau"
else
  FFMPEG_VDPAU="--disable-vdpau"
fi

if [ "$DEBUG" = yes ]; then
  FFMPEG_DEBUG="--enable-debug --disable-stripping"
else
  FFMPEG_DEBUG="--disable-debug --enable-stripping"
fi

if [ "$OPTIMIZATIONS" = size ]; then
  FFMPEG_OPTIM="--disable-small"
else
  FFMPEG_OPTIM="--disable-small"
fi

if [ "$CRYSTALHD" = yes ]; then
# disabled, we use XBMC's internal solution
  FFMPEG_CRYSTALHD="--disable-crystalhd"
else
  FFMPEG_CRYSTALHD="--disable-crystalhd"
fi

case "$TARGET_ARCH" in
  arm)
      FFMPEG_CPU=""
      FFMPEG_TABLES="--enable-hardcoded-tables"
      FFMPEG_PIC="--enable-pic"
  ;;
  i?86)
      FFMPEG_CPU=""
      FFMPEG_TABLES="--disable-hardcoded-tables"
      FFMPEG_PIC="--disable-pic"
  ;;
  x86_64)
      FFMPEG_CPU=""
      FFMPEG_TABLES="--disable-hardcoded-tables"
      FFMPEG_PIC="--enable-pic"
  ;;
esac

case "$TARGET_FPU" in
  neon*)
      FFMPEG_FPU="--enable-neon"
  ;;
  vfp*)
      FFMPEG_FPU=""
  ;;
  *)
      FFMPEG_FPU=""
  ;;
esac

pre_configure_target() {
  cd $ROOT/$PKG_BUILD
  rm -rf .$TARGET_NAME

  export pkg_config="$ROOT/$TOOLCHAIN/bin/pkg-config"

# ffmpeg fails building with LTO support
  strip_lto

# ffmpeg fails running with GOLD support
  strip_gold
}

configure_target() {
  ./configure --prefix=/usr \
              --cpu=$TARGET_CPU \
              --arch=$TARGET_ARCH \
              --enable-cross-compile \
              --cross-prefix=$TARGET_PREFIX \
              --sysroot=$SYSROOT_PREFIX \
              --sysinclude="$SYSROOT_PREFIX/usr/include" \
              --target-os="linux" \
              --extra-version="$PKG_VERSION" \
              --nm="$NM" \
              --ar="$AR" \
              --as="$CC" \
              --cc="$CC" \
              --ld="$CC" \
              --host-cc="$HOST_CC" \
              --host-cflags="$HOST_CFLAGS" \
              --host-ldflags="$HOST_LDFLAGS" \
              --host-libs="-lm" \
              --extra-cflags="$CFLAGS" \
              --extra-ldflags="$LDFLAGS" \
              --extra-libs="" \
              --extra-version="" \
              --build-suffix="" \
              --enable-static \
              --disable-shared \
              --enable-gpl \
              --disable-version3 \
              --disable-nonfree \
              --enable-logging \
              --disable-doc \
              $FFMPEG_DEBUG \
              $FFMPEG_PIC \
              --enable-optimizations \
              --disable-armv5te --disable-armv6t2 \
              --disable-extra-warnings \
              --disable-ffprobe \
              --disable-ffplay \
              --disable-ffserver \
              --enable-ffmpeg \
              --enable-avdevice \
              --enable-avcodec \
              --enable-avformat \
              --enable-swscale \
              --enable-postproc \
              --enable-avfilter \
              --disable-devices \
              --enable-pthreads \
              --disable-w32threads \
              --disable-x11grab \
              --enable-network \
              --enable-gnutls \
              --disable-gray \
              --enable-swscale-alpha \
              $FFMPEG_OPTIM \
              --enable-dct \
              --enable-fft \
              --enable-mdct \
              --enable-rdft \
              $FFMPEG_CRYSTALHD \
              $FFMPEG_VAAPI \
              $FFMPEG_VDPAU \
              --disable-dxva2 \
              --enable-runtime-cpudetect \
              $FFMPEG_TABLES \
              --disable-memalign-hack \
              --disable-encoders \
              --enable-encoder=ac3 \
              --enable-encoder=aac \
              --enable-encoder=wmav2 \
              --disable-decoder=mpeg_xvmc \
              --enable-hwaccels \
              --disable-muxers \
              --enable-muxer=spdif \
              --enable-muxer=adts \
              --enable-muxer=asf \
              --enable-muxer=ipod \
              --enable-demuxers \
              --enable-parsers \
              --enable-bsfs \
              --enable-protocol=http \
              --disable-indevs \
              --disable-outdevs \
              --enable-filters \
              --disable-avisynth \
              --enable-bzlib \
              --disable-frei0r \
              --disable-libopencore-amrnb \
              --disable-libopencore-amrwb \
              --disable-libopencv \
              --disable-libdc1394 \
              --disable-libfaac \
              --disable-libfreetype \
              --disable-libgsm \
              --disable-libmp3lame \
              --disable-libnut \
              --disable-libopenjpeg \
              --disable-librtmp \
              --disable-libschroedinger \
              --disable-libspeex \
              --disable-libtheora \
              --disable-libvo-aacenc \
              --disable-libvo-amrwbenc \
              --enable-libvorbis --enable-muxer=ogg --enable-encoder=libvorbis \
              --disable-libvpx \
              --disable-libx264 \
              --disable-libxavs \
              --disable-libxvid \
              --enable-zlib \
              --enable-asm \
              --disable-altivec \
              $FFMPEG_CPU \
              $FFMPEG_FPU \
              --disable-vis \
              --enable-yasm \
              --disable-sram \
              --disable-symver
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
  rm -rf $INSTALL/usr/share/ffmpeg/examples
}
