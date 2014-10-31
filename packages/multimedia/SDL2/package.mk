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

PKG_NAME="SDL2"
PKG_VERSION="2.0.3"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.libsdl.org/"
PKG_URL="http://www.libsdl.org/release/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain yasm:host alsa-lib systemd dbus"
PKG_PRIORITY="optional"
PKG_SECTION="multimedia"
PKG_SHORTDESC="SDL2: A cross-platform Graphic API"
PKG_LONGDESC="Simple DirectMedia Layer is a cross-platform multimedia library designed to provide fast access to the graphics framebuffer and audio device. It is used by MPEG playback software, emulators, and many popular games, including the award winning Linux port of 'Civilization: Call To Power.' Simple DirectMedia Layer supports Linux, Win32, BeOS, MacOS, Solaris, IRIX, and FreeBSD."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared --enable-static \
                           --enable-libc \
                           --enable-gcc-atomics \
                           --enable-atomic \
                           --enable-audio \
                           --enable-render \
                           --enable-events \
                           --enable-joystick \
                           --enable-haptic \
                           --enable-power \
                           --enable-filesystem \
                           --enable-threads \
                           --enable-timers \
                           --enable-file \
                           --enable-loadso \
                           --enable-cpuinfo \
                           --enable-assembly \
                           --disable-altivec \
                           --disable-oss \
                           --enable-alsa --disable-alsatest --enable-alsa-shared \
                           --with-alsa-prefix=$SYSROOT_PREFIX/usr/lib \
                           --with-alsa-inc-prefix=$SYSROOT_PREFIX/usr/include \
                           --disable-esd --disable-esdtest --disable-esd-shared \
                           --disable-arts --disable-arts-shared \
                           --disable-nas --enable-nas-shared \
                           --disable-sndio --enable-sndio-shared \
                           --disable-diskaudio \
                           --disable-dummyaudio \
                           --disable-video-wayland --enable-video-wayland-qt-touch --disable-wayland-shared \
                           --disable-video-mir --disable-mir-shared \
                           --disable-video-cocoa \
                           --disable-video-directfb --disable-directfb-shared \
                           --disable-fusionsound --disable-fusionsound-shared \
                           --disable-video-dummy \
                           --enable-libudev \
                           --enable-dbus \
                           --disable-input-tslib \
                           --enable-pthreads --enable-pthread-sem \
                           --disable-directx \
                           --enable-sdl-dlopen \
                           --disable-clock_gettime \
                           --disable-rpath \
                           --disable-render-d3d"



if [ "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libX11 libXrandr"

  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --enable-video --enable-video-x11 --enable-x11-shared"
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --disable-video-x11-xcursor --disable-video-x11-xinerama"
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --disable-video-x11-xinput --enable-video-x11-xrandr"
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --disable-video-x11-scrnsaver --disable-video-x11-xshape"
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --disable-video-x11-vm --with-x"
else
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --disable-video --disable-video-x11 --disable-x11-shared"
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --disable-video-x11-xcursor --disable-video-x11-xinerama"
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --disable-video-x11-xinput --disable-video-x11-xrandr"
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --disable-video-x11-scrnsaver --disable-video-x11-xshape"
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --disable-video-x11-vm --without-x"
fi

if [ ! "$OPENGL" = "no" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OPENGL glu"

  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --enable-video-opengl --disable-video-opengles"
else
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --disable-video-opengl --disable-video-opengles"
fi

if [ "$PULSEAUDIO_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET pulseaudio"

  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --enable-pulseaudio --enable-pulseaudio-shared"
else
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --disable-pulseaudio --disable-pulseaudio-shared"
fi

pre_make_target() {
# dont build parallel
  MAKEFLAGS=-j1
}

post_makeinstall_target() {
  mkdir -p $ROOT/$TOOLCHAIN/bin
    cp $SYSROOT_PREFIX/usr/bin/sdl2-config $ROOT/$TOOLCHAIN/bin
    $SED "s:\(['=\" ]\)/usr:\\1$SYSROOT_PREFIX/usr:g" $SYSROOT_PREFIX/usr/bin/sdl2-config

  rm -rf $INSTALL/usr/bin
}
