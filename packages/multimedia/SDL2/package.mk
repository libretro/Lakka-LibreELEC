# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="SDL2"
PKG_VERSION="2.26.0"
PKG_SHA256="8000d7169febce93c84b6bdf376631f8179132fd69f7015d4dadb8b9c2bdb295"
PKG_LICENSE="GPL"
PKG_SITE="https://www.libsdl.org/"
PKG_URL="https://www.libsdl.org/release/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain alsa-lib systemd dbus"
PKG_LONGDESC="A cross-platform multimedia library designed to provide fast access to the graphics framebuffer and audio device. "
PKG_BUILD_FLAGS="+pic"

if [ "${TARGET_ARCH}" = "x86_64" ]; then
  PKG_DEPENDS_TARGET+=" nasm:host"
  PKG_SDL2_X86ASM="-DSDL_ASSEMBLY=ON"
else
  # Only x86(-64) and ppc assembly present as of 2.0.8
  PKG_SDL2_X86ASM="-DSDL_ASSEMBLY=OFF"
fi

PKG_CMAKE_OPTS_TARGET="-DSDL_STATIC=ON \
                       -DSDL_SHARED=OFF \
                       -DSDL_LIBC=ON \
                       -DSDL_GCC_ATOMICS=ON \
                       ${PKG_SDL2_X86ASM} \
                       -DSDL_ALTIVEC=OFF \
                       -DSDL_OSS=OFF \
                       -DSDL_ALSA=ON \
                       -DSDL_ALSA_SHARED=ON \
                       -DSDL_ESD=OFF \
                       -DSDL_ESD_SHARED=OFF \
                       -DSDL_ARTS=OFF \
                       -DSDL_ARTS_SHARED=OFF \
                       -DSDL_NAS=OFF \
                       -DSDL_NAS_SHARED=ON \
                       -DSDL_SNDIO=OFF \
                       -DSDL_DISKAUDIO=OFF \
                       -DSDL_DUMMYAUDIO=OFF \
                       -DSDL_WAYLAND=OFF \
                       -DSDL_WAYLAND_QT_TOUCH=ON \
                       -DSDL_WAYLAND_SHARED=OFF \
                       -DSDL_COCOA=OFF \
                       -DSDL_DIRECTFB=OFF \
                       -DSDL_DIRECTFB_SHARED=OFF \
                       -DSDL_FUSIONSOUND=OFF \
                       -DSDL_FUSIONSOUND_SHARED=OFF \
                       -DSDL_DUMMYVIDEO=OFF \
                       -DSDL_PTHREADS=ON \
                       -DSDL_PTHREADS_SEM=ON \
                       -DSDL_DIRECTX=OFF \
                       -DSDL_LOADSO=ON \
                       -DSDL_CLOCK_GETTIME=OFF \
                       -DSDL_RPATH=OFF \
                       -DSDL_KMSDRM=OFF \
                       -DSDL_RENDER_D3D=OFF"

if [ "${DISPLAYSERVER}" = "x11" ]; then
  PKG_DEPENDS_TARGET+=" libX11 libXrandr"

  PKG_CMAKE_OPTS_TARGET="${PKG_CMAKE_OPTS_TARGET} \
                         -DSDL_X11=ON \
                         -DSDL_X11_SHARED=ON \
                         -DSDL_X11_XCURSOR=OFF \
                         -DSDL_X11_XINERAMA=OFF \
                         -DSDL_X11_XINPUT=OFF \
                         -DSDL_X11_XRANDR=ON \
                         -DSDL_X11_XSCRNSAVER=OFF \
                         -DSDL_X11_XSHAPE=OFF \
                         -DSDL_X11_XVM=OFF"
else
  PKG_CMAKE_OPTS_TARGET="${PKG_CMAKE_OPTS_TARGET} \
                         -DSDL_X11=OFF"
fi

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"

  PKG_CMAKE_OPTS_TARGET="${PKG_CMAKE_OPTS_TARGET} \
                         -DSDL_OPENGL=ON \
                         -DSDL_OPENGLES=OFF"
else
  PKG_CMAKE_OPTS_TARGET="${PKG_CMAKE_OPTS_TARGET} \
                         -DSDL_OPENGL=OFF \
                         -DSDL_OPENGLES=ON"
fi

if [ "${PULSEAUDIO_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" pulseaudio"

  PKG_CMAKE_OPTS_TARGET="${PKG_CMAKE_OPTS_TARGET} \
                         -DSDL_PULSEAUDIO=ON \
                         -DSDL_PULSEAUDIO_SHARED=ON"
else
  PKG_CMAKE_OPTS_TARGET="${PKG_CMAKE_OPTS_TARGET} \
                         -DSDL_PULSEAUDIO=OFF \
                         -DSDL_PULSEAUDIO_SHARED=OFF"
fi

post_makeinstall_target() {
  sed -e "s:\(['=\" ]\)/usr:\\1${SYSROOT_PREFIX}/usr:g" -i ${SYSROOT_PREFIX}/usr/bin/sdl2-config

  rm -rf ${INSTALL}/usr/bin
}
