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

PKG_NAME="ffmpegx"
PKG_VERSION="libreelec"
PKG_REV="7"
PKG_ARCH="any"
PKG_LICENSE="LGPLv2.1+"
PKG_SITE="https://ffmpeg.org"
PKG_DEPENDS_TARGET="toolchain ffmpeg lame x264"
PKG_SECTION="multimedia"
PKG_SHORTDESC="FFmpeg+"
PKG_LONGDESC="FFmpeg built static with additional features"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_configure_target() {
  cd "$PKG_BUILD"
  rm -rf ".$TARGET_NAME"
  cp -PR $(get_build_dir ffmpeg)/* .
  make clean

# ffmpeg builds better with these options
  strip_gold
  strip_lto

  if [ "$KODIPLAYER_DRIVER" == "bcm2835-driver" ]; then
    CFLAGS="-DRPI=1 -I$SYSROOT_PREFIX/usr/include/IL -I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads -I$SYSROOT_PREFIX/usr/include/interface/vmcs_host/linux $CFLAGS"
    FFMPEG_LIBS="-lbcm_host -ldl -lmmal -lmmal_core -lmmal_util -lvchiq_arm -lvcos -lvcsm"
    FFMPEG_RPI_HADE="--enable-mmal --enable-omx-rpi"
  fi

# ffmpeg does not build with libx264 on aarch64
  if [ "$TARGET_ARCH" != "aarch64" ]; then
    FFMPEG_X264="--enable-libx264"
  fi

  if [ "$TARGET_ARCH" == "arm" ]; then
    FFMPEG_ARM_AO="--enable-hardcoded-tables"
  fi
}

configure_target() {
  ./configure \
    \
    `#Licensing options` \
    --enable-gpl \
    \
    `#Documentation options` \
    --disable-doc \
    \
    `#Hardware accelerated decoding encoding` \
    $FFMPEG_RPI_HADE \
    \
    `#External library support` \
    --enable-libmp3lame \
    $FFMPEG_X264 \
    --enable-openssl \
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
    --host-libs="-lm" \
    --extra-cflags="$CFLAGS" \
    --extra-ldflags="$LDFLAGS" \
    --extra-libs="$FFMPEG_LIBS" \
    --extra-version="x" \
    --enable-pic \
    \
    `#Advanced options` \
    $FFMPEG_ARM_AO \

}

makeinstall_target() {
  make install DESTDIR=$INSTALL
}

post_makeinstall_target() {
  for ff in $INSTALL/usr/local/bin/*; do mv $ff ${ff}x; done
  rm -fr $INSTALL/usr/local/include
  rm -fr $INSTALL/usr/local/share/ffmpeg/examples
}
