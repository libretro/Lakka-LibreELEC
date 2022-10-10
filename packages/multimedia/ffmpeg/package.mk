# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ffmpeg"
PKG_LICENSE="LGPLv2.1+"
PKG_SITE="https://ffmpeg.org"
PKG_DEPENDS_TARGET="toolchain zlib bzip2 openssl speex"
if [ "${DISTRO}" = "Lakka" ]; then
  PKG_DEPENDS_TARGET+=" libx264 lame rtmpdump"
fi
PKG_LONGDESC="FFmpeg is a complete, cross-platform solution to record, convert and stream audio and video."

case "${PROJECT}" in
  Amlogic)
    PKG_VERSION="0e5290bcac015e52f6a65dafaf41ea125816257f"
    PKG_FFMPEG_BRANCH="dev/4.4/rpi_import_1"
    PKG_SHA256="4bd6e56920b90429bc09e43cda554f5bb9125c4ac090b4331fc459bb709eea68"
    PKG_URL="https://github.com/jc-kynesim/rpi-ffmpeg/archive/${PKG_VERSION}.tar.gz"
    PKG_PATCH_DIRS="libreelec dav1d"
    ;;
  RPi)
    PKG_VERSION="4.4.1-Nexus-Alpha1"
    PKG_SHA256="abbce62231baffe237e412689c71ffe01bfc83135afd375f1e538caae87729ed"
    PKG_URL="https://github.com/xbmc/FFmpeg/archive/${PKG_VERSION}.tar.gz"
    PKG_FFMPEG_RPI="--disable-mmal --disable-rpi --enable-sand"
    PKG_PATCH_DIRS="libreelec rpi"
    ;;
  L4T)
    PKG_VERSION="4.4.1-Nexus-Alpha1"
    PKG_SHA256="abbce62231baffe237e412689c71ffe01bfc83135afd375f1e538caae87729ed"
    PKG_URL="https://github.com/xbmc/FFmpeg/archive/${PKG_VERSION}.tar.gz"
    PKG_DEPENDS_TARGET+=" tegra-bsp:host"
    PKG_PATCH_DIRS+="libreelec v4l2-request v4l2-drmprime L4T"
    PKG_FFMPEG_NVV4L2="--enable-nvv4l2"
    EXTRA_CFLAGS="-I${SYSROOT_PREFIX}/usr/src/jetson_multimedia_api/include"
    ;;
  *)
    PKG_VERSION="4.4.1-Nexus-Alpha1"
    PKG_SHA256="abbce62231baffe237e412689c71ffe01bfc83135afd375f1e538caae87729ed"
    PKG_URL="https://github.com/xbmc/FFmpeg/archive/${PKG_VERSION}.tar.gz"
    PKG_PATCH_DIRS="libreelec v4l2-request v4l2-drmprime"
    ;;
esac

post_unpack() {
  # Fix FFmpeg version
  if [ "${PROJECT}" = "Amlogic" ]; then
    echo "${PKG_FFMPEG_BRANCH}-${PKG_VERSION:0:7}" > ${PKG_BUILD}/VERSION
  else
    echo "${PKG_VERSION}" > ${PKG_BUILD}/RELEASE
  fi
}

# Dependencies
get_graphicdrivers

PKG_FFMPEG_HWACCEL="--enable-hwaccels"

if [ "${V4L2_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" libdrm"
  PKG_NEED_UNPACK+=" $(get_pkg_directory libdrm)"
  PKG_FFMPEG_V4L2="--enable-v4l2_m2m --enable-libdrm"

  if [ "${PROJECT}" = "Allwinner" -o "${PROJECT}" = "Rockchip" -o "${DEVICE}" = "iMX8" ]; then
    PKG_V4L2_REQUEST="yes"
  elif [ "${PROJECT}" = "RPi" -a "${DEVICE}" = "RPi4" ]; then
    PKG_V4L2_REQUEST="yes"
    PKG_FFMPEG_HWACCEL="--disable-hwaccel=h264_v4l2request \
                        --disable-hwaccel=mpeg2_v4l2request \
                        --disable-hwaccel=vp8_v4l2request \
                        --disable-hwaccel=vp9_v4l2request"
  else
    PKG_V4L2_REQUEST="no"
  fi

  if [ "${PKG_V4L2_REQUEST}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" systemd"
    PKG_NEED_UNPACK+=" $(get_pkg_directory systemd)"
    PKG_FFMPEG_V4L2+=" --enable-libudev --enable-v4l2-request"
  else
    PKG_FFMPEG_V4L2+=" --disable-libudev --disable-v4l2-request"
  fi
else
  PKG_FFMPEG_V4L2="--disable-v4l2_m2m --disable-libudev --disable-v4l2-request"
fi

if [ "${VAAPI_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" libva"
  PKG_NEED_UNPACK+=" $(get_pkg_directory libva)"
  PKG_FFMPEG_VAAPI="--enable-vaapi"
else
  PKG_FFMPEG_VAAPI="--disable-vaapi"
fi

if [ "${DISPLAYSERVER}" != "x11" ]; then
  PKG_DEPENDS_TARGET+=" libdrm"
  PKG_NEED_UNPACK+=" $(get_pkg_directory libdrm)"
  PKG_FFMPEG_VAAPI=" --enable-libdrm"
fi

if [ "${VDPAU_SUPPORT}" = "yes" -a "${DISPLAYSERVER}" = "x11" ]; then
  PKG_DEPENDS_TARGET+=" libvdpau"
  PKG_NEED_UNPACK+=" $(get_pkg_directory libvdpau)"
  PKG_FFMPEG_VDPAU="--enable-vdpau"
else
  PKG_FFMPEG_VDPAU="--disable-vdpau"
fi

if build_with_debug; then
  PKG_FFMPEG_DEBUG="--enable-debug --disable-stripping"
else
  PKG_FFMPEG_DEBUG="--disable-debug --enable-stripping"
fi

if target_has_feature neon; then
  PKG_FFMPEG_FPU="--enable-neon"
else
  PKG_FFMPEG_FPU="--disable-neon"
fi

if [ "${TARGET_ARCH}" = "x86_64" ]; then
  PKG_DEPENDS_TARGET+=" nasm:host"
fi

if target_has_feature "(neon|sse)"; then
  PKG_DEPENDS_TARGET+=" dav1d"
  PKG_NEED_UNPACK+=" $(get_pkg_directory dav1d)"
  PKG_FFMPEG_AV1="--enable-libdav1d"
else
  PKG_FFMPEG_AV1="--disable-libdav1d"
fi

pre_configure_target() {
  cd ${PKG_BUILD}
  rm -rf .${TARGET_NAME}
}

if [ "${FFMPEG_TESTING}" = "yes" ]; then
  PKG_FFMPEG_TESTING="--enable-encoder=wrapped_avframe --enable-muxer=null"
  if [ "${PROJECT}" = "RPi" ]; then
    PKG_FFMPEG_TESTING+=" --enable-vout-drm --enable-outdev=vout_drm"
  fi
else
  PKG_FFMPEG_TESTING="--disable-programs"
fi

configure_target() {
   CONFIG_OPTIONS_STANDARD_FFMPEG=" --disable-static \
              --enable-shared \
              --enable-gpl \
              --disable-version3 \
              --enable-logging \
              --disable-doc \
              ${PKG_FFMPEG_DEBUG} \
              --enable-pic \
              --enable-optimizations \
              --disable-extra-warnings \
              --disable-programs \
              --enable-avdevice \
              --enable-avcodec \
              --enable-avformat \
              --enable-swscale \
              --enable-postproc \
              --enable-avfilter \
              --disable-devices \
              --enable-pthreads \
              --enable-network \
              --enable-gnutls --disable-openssl \
              --disable-gray \
              --enable-swscale-alpha \
              --disable-small \
              --enable-dct \
              --enable-fft \
              --enable-mdct \
              --enable-rdft \
              --disable-crystalhd \
              ${PKG_FFMPEG_V4L2} \
              ${PKG_FFMPEG_VAAPI} \
              ${PKG_FFMPEG_VDPAU} \
              ${PKG_FFMPEG_RPI} \
              --enable-runtime-cpudetect \
              --disable-hardcoded-tables \
              --disable-encoders \
              --enable-encoder=ac3 \
              --enable-encoder=aac \
              --enable-encoder=wmav2 \
              --enable-encoder=mjpeg \
              --enable-encoder=png \
              ${PKG_FFMPEG_HWACCEL} \
              --disable-muxers \
              --enable-muxer=spdif \
              --enable-muxer=adts \
              --enable-muxer=asf \
              --enable-muxer=ipod \
              --enable-muxer=mpegts \
              --enable-demuxers \
              --enable-parsers \
              --enable-bsfs \
              --enable-protocol=http \
              --disable-indevs \
              --disable-outdevs \
              --enable-filters \
              --disable-avisynth \
              --enable-bzlib \
              --disable-lzma \
              --disable-alsa \
              --disable-frei0r \
              --disable-libopencore-amrnb \
              --disable-libopencore-amrwb \
              --disable-libopencv \
              --disable-libdc1394 \
              --disable-libfreetype \
              --disable-libgsm \
              --disable-libmp3lame \
              --disable-libopenjpeg \
              --disable-librtmp \
              ${PKG_FFMPEG_AV1} \
              --enable-libspeex \
              --disable-libtheora \
              --disable-libvo-amrwbenc \
              --disable-libvorbis \
              --disable-libvpx \
              --disable-libx264 \
              --disable-libxavs \
              --disable-libxvid \
              --enable-zlib \
              --enable-asm \
              --disable-altivec \
              ${PKG_FFMPEG_FPU} \
              --disable-symver \
              ${PKG_FFMPEG_NVV4L2} \
              ${PKG_FFMPEG_VULKAN}"

  if [  "${DISTRO}" = "Lakka" ]; then
    CONFIG_OPTIONS_STANDARD_FFMPEG=${CONFIG_OPTIONS_STANDARD_FFMPEG/"--disable-encoders "/"--enable-encoders "}
    CONFIG_OPTIONS_STANDARD_FFMPEG=${CONFIG_OPTIONS_STANDARD_FFMPEG/"--enable-encoder=ac3 "/""}
    CONFIG_OPTIONS_STANDARD_FFMPEG=${CONFIG_OPTIONS_STANDARD_FFMPEG/"--enable-encoder=aac "/""}
    CONFIG_OPTIONS_STANDARD_FFMPEG=${CONFIG_OPTIONS_STANDARD_FFMPEG/"--enable-encoder=wmav2 "/""}
    CONFIG_OPTIONS_STANDARD_FFMPEG=${CONFIG_OPTIONS_STANDARD_FFMPEG/"--enable-encoder=mjpeg "/""}
    CONFIG_OPTIONS_STANDARD_FFMPEG=${CONFIG_OPTIONS_STANDARD_FFMPEG/"--enable-encoder=png "/""}
    CONFIG_OPTIONS_STANDARD_FFMPEG=${CONFIG_OPTIONS_STANDARD_FFMPEG/"--disable-muxers "/"--enable-muxers "}
    CONFIG_OPTIONS_STANDARD_FFMPEG=${CONFIG_OPTIONS_STANDARD_FFMPEG/"--enable-muxer=spdif "/""}
    CONFIG_OPTIONS_STANDARD_FFMPEG=${CONFIG_OPTIONS_STANDARD_FFMPEG/"--enable-muxer=adts "/""}
    CONFIG_OPTIONS_STANDARD_FFMPEG=${CONFIG_OPTIONS_STANDARD_FFMPEG/"--enable-muxer=asf "/""}
    CONFIG_OPTIONS_STANDARD_FFMPEG=${CONFIG_OPTIONS_STANDARD_FFMPEG/"--enable-muxer=ipod "/""}
    CONFIG_OPTIONS_STANDARD_FFMPEG=${CONFIG_OPTIONS_STANDARD_FFMPEG/"--enable-muxer=mpegts "/""}
    CONFIG_OPTIONS_STANDARD_FFMPEG=${CONFIG_OPTIONS_STANDARD_FFMPEG/"--disable-libmp3lame "/"--enable-libmp3lame "}
    CONFIG_OPTIONS_STANDARD_FFMPEG=${CONFIG_OPTIONS_STANDARD_FFMPEG/"--disable-librtmp  "/"--enable-librtmp "}
    CONFIG_OPTIONS_STANDARD_FFMPEG=${CONFIG_OPTIONS_STANDARD_FFMPEG/"--disable-libx264 "/"--enable-libx264 "}
  fi

  ./configure --prefix="/usr" \
              --cpu="${TARGET_CPU}" \
              --arch="${TARGET_ARCH}" \
              --enable-cross-compile \
              --cross-prefix="${TARGET_PREFIX}" \
              --sysroot="${SYSROOT_PREFIX}" \
              --sysinclude="${SYSROOT_PREFIX}/usr/include" \
              --target-os="linux" \
              --nm="${NM}" \
              --ar="${AR}" \
              --as="${CC}" \
              --cc="${CC}" \
              --ld="${CC}" \
              --host-cc="${HOST_CC}" \
              --host-cflags="${HOST_CFLAGS}" \
              --host-ldflags="${HOST_LDFLAGS}" \
              --extra-cflags="${CFLAGS} ${EXTRA_CFLAGS}" \
              --extra-ldflags="${LDFLAGS}" \
              --extra-libs="${PKG_FFMPEG_LIBS}" \
              --pkg-config="${TOOLCHAIN}/bin/pkg-config" \
              ${CONFIG_OPTIONS_STANDARD_FFMPEG}

}

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/share/ffmpeg/examples
}
