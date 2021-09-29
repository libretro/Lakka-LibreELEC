PKG_NAME="SDL"
PKG_VERSION="1.2.15"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://www.libsdl.org/"
PKG_URL="https://www.libsdl.org/release/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain:host"
PKG_DEPENDS_TARGET="toolchain yasm:host alsa-lib systemd dbus SDL:host"
PKG_SECTION="multimedia"
PKG_LONGDESC="SDL: A cross-platform Graphic API"

PKG_CONFIGURE_OPTS_TARGET="--enable-shared \
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
                           --enable-alsa \
                           --disable-alsatest \
                           --enable-alsa-shared \
                           --with-alsa-prefix=${SYSROOT_PREFIX}/usr/lib \
                           --with-alsa-inc-prefix=${SYSROOT_PREFIX}/usr/include \
                           --disable-esd \
                           --disable-esdtest \
                           --disable-esd-shared \
                           --disable-arts \
                           --disable-arts-shared \
                           --disable-nas \
                           --enable-nas-shared \
                           --disable-sndio \
                           --enable-sndio-shared \
                           --disable-diskaudio \
                           --disable-dummyaudio \
                           --disable-video-wayland \
                           --enable-video-wayland-qt-touch \
                           --disable-wayland-shared \
                           --disable-video-mir \
                           --disable-mir-shared \
                           --disable-video-cocoa \
                           --disable-video-directfb \
                           --disable-directfb-shared \
                           --disable-fusionsound \
                           --disable-fusionsound-shared \
                           --disable-video-dummy \
                           --enable-libudev \
                           --enable-dbus \
                           --disable-input-tslib \
                           --enable-pthreads \
                           --enable-pthread-sem \
                           --disable-directx \
                           --enable-sdl-dlopen \
                           --disable-clock_gettime \
                           --disable-rpath \
                           --disable-render-d3d \
                           --disable-video \
                           --disable-video-x11 \
                           --disable-x11-shared \
                           --disable-video-x11-xcursor \
                           --disable-video-x11-xinerama \
                           --disable-video-x11-xinput \
                           --disable-video-x11-xrandr \
                           --disable-video-x11-scrnsaver \
                           --disable-video-x11-xshape \
                           --disable-video-x11-vm --without-x"

PKG_CONFIGURE_OPTS_HOST="${PKG_CONFIGURE_OPTS_TARGET}"


if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu"
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-video-opengl --disable-video-opengles"
elif [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-video-opengles --disable-video-opengl"
else
  PKG_CONFIGURE_OPTS_TARGET+=" --disable-video-opengl --disable-video-opengles"
fi

if [ "${PULSEAUDIO_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" pulseaudio"

  PKG_CONFIGURE_OPTS_TARGET+=" --enable-pulseaudio --enable-pulseaudio-shared"
else
  PKG_CONFIGURE_OPTS_TARGET+=" --disable-pulseaudio --disable-pulseaudio-shared"
fi

PKG_MAKE_OPTS_TARGET="-j1"

post_makeinstall_target() {
  sed "s:\(['=\" ]\)/usr:\\1${SYSROOT_PREFIX}/usr:g" ${SYSROOT_PREFIX}/usr/bin/sdl-config
  rm -vrf ${INSTALL}/usr/bin
}
