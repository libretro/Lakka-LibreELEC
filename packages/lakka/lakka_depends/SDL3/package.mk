# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="SDL3"
PKG_VERSION="3.4.14"
PKG_SHA256="30d4aa2b3037718142b32dffd4e72f917ebb6cc5227150e7bb9c45efb2153aeb"
PKG_LICENSE="ZLIB"
PKG_SITE="https://www.libsdl.org"
PKG_URL="https://www.libsdl.org/release/SDL3-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain dbus libusb systemd"
PKG_SECTION="multimedia"
PKG_LONGDESC="SDL3: A cross-platform library for audio, input, video and GPU access"
PKG_TOOLCHAIN="cmake"
PKG_BUILD_FLAGS="+pic"

# Only options deviating from SDL's defaults are listed. We disable packages
# that we explicitely want to be disabled, the rest use SDL's detection.
PKG_CMAKE_OPTS_TARGET="-DCMAKE_INSTALL_LIBDIR=lib \
                       -DSDL_STATIC=OFF \
                       -DSDL_DIALOG=OFF \
                       -DSDL_TRAY=OFF \
                       -DSDL_IBUS=OFF \
                       -DSDL_JACK=OFF \
                       -DSDL_SNDIO=OFF \
                       -DSDL_LIBURING=OFF \
                       -DSDL_RPATH=OFF \
                       -DSDL_TESTS=OFF \
                       -DSDL_TEST_LIBRARY=OFF \
                       -DSDL_INSTALL_CPACK=OFF"

# Audio
if [ "${ALSA_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" alsa-lib"
else
  PKG_CMAKE_OPTS_TARGET+=" -DSDL_ALSA=OFF"
fi

if [ "${PULSEAUDIO_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" pulseaudio"
else
  PKG_CMAKE_OPTS_TARGET+=" -DSDL_PULSEAUDIO=OFF"
fi

if [ "${PIPEWIRE_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" pipewire"
else
  PKG_CMAKE_OPTS_TARGET+=" -DSDL_PIPEWIRE=OFF"
fi

# Video
if [ "${DISPLAYSERVER}" = "x11" ]; then
  PKG_DEPENDS_TARGET+=" libX11 libXcursor libXext libXfixes libXi libXrandr libXrender libXtst"
  # Xscrnsaver, fribidi and libthai default on with X11 but are not deps here
  PKG_CMAKE_OPTS_TARGET+=" -DSDL_X11_XSCRNSAVER=OFF \
                           -DSDL_FRIBIDI=OFF \
                           -DSDL_LIBTHAI=OFF"
else
  PKG_CMAKE_OPTS_TARGET+=" -DSDL_X11=OFF"
fi

if [ "${DISPLAYSERVER}" = "wl" ]; then
  PKG_DEPENDS_TARGET+=" wayland wayland-protocols libxkbcommon"
  PKG_CMAKE_OPTS_TARGET+=" -DSDL_WAYLAND_LIBDECOR=OFF"
else
  PKG_CMAKE_OPTS_TARGET+=" -DSDL_WAYLAND=OFF"
fi

if [ "${DISPLAYSERVER}" = "no" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DSDL_UNIX_CONSOLE_BUILD=ON"
fi

# KMS/DRM needs gbm, which only mesa provides
if [ "${DISPLAYSERVER}" = "no" ] && [ "${OPENGLES}" = "mesa" -o "${OPENGL}" = "mesa" ]; then
  PKG_DEPENDS_TARGET+=" libdrm"
else
  PKG_CMAKE_OPTS_TARGET+=" -DSDL_KMSDRM=OFF"
fi

# Graphics
if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
else
  PKG_CMAKE_OPTS_TARGET+=" -DSDL_OPENGL=OFF"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
else
  PKG_CMAKE_OPTS_TARGET+=" -DSDL_OPENGLES=OFF"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
else
  PKG_CMAKE_OPTS_TARGET+=" -DSDL_VULKAN=OFF"
fi
