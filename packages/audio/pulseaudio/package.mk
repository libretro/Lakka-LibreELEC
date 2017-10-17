################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="pulseaudio"
PKG_VERSION="11.0"
PKG_SHA256="072305d4018fc5e75bb1b45ee6b938fa52fc9fd27493bf327415ef89ed14c969"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://pulseaudio.org/"
PKG_URL="http://www.freedesktop.org/software/pulseaudio/releases/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain libtool alsa-lib libsndfile soxr dbus systemd openssl libcap"
PKG_SECTION="audio"
PKG_SHORTDESC="pulseaudio: Yet another sound server for Unix"
PKG_LONGDESC="PulseAudio is a sound server for Linux and other Unix-like operating systems. It is intended to be an improved drop-in replacement for the Enlightened Sound Daemon (esound or esd). In addition to the features esound provides, PulseAudio has an extensible plugin architecture, support for more than one sink per source, better low-latency behavior, the ability to be embedded into other software, a completely asynchronous C API, a simple command line interface for reconfiguring the daemon while running, flexible and implicit sample type conversion and resampling, and a "Zero-Copy" architecture."
PKG_AUTORECONF="no"

if [ "$BLUETOOTH_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET sbc"
  PULSEAUDIO_BLUETOOTH="--enable-bluez5"
else
  PULSEAUDIO_BLUETOOTH="--disable-bluez5"
fi

if [ "$AVAHI_DAEMON" = "yes" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET avahi"
  PULSEAUDIO_AVAHI="--enable-avahi"
else
  PULSEAUDIO_AVAHI="--disable-avahi"
fi

# PulseAudio fails to build on aarch64 when NEON is enabled, so don't enable NEON for aarch64 until upstream supports it
if [ "$TARGET_ARCH" = "arm" ] && target_has_feature neon; then
  PULSEAUDIO_NEON="--enable-neon-opt"
else
  PULSEAUDIO_NEON="--disable-neon-opt"
fi

# package specific configure options
PKG_CONFIGURE_OPTS_TARGET="--disable-silent-rules \
                           --disable-nls \
                           --enable-largefile \
                           --disable-rpath \
                           $PULSEAUDIO_NEON \
                           --disable-x11 \
                           --disable-tests \
                           --disable-samplerate \
                           --disable-oss-output \
                           --disable-oss-wrapper \
                           --disable-coreaudio-output \
                           --enable-alsa \
                           --disable-esound \
                           --disable-solaris \
                           --disable-waveout \
                           --enable-glib2 \
                           --disable-gtk3 \
                           --disable-gconf \
                           $PULSEAUDIO_AVAHI \
                           --disable-jack \
                           --disable-asyncns \
                           --disable-tcpwrap \
                           --disable-lirc \
                           --enable-dbus \
                           --disable-bluez4 \
                           $PULSEAUDIO_BLUETOOTH \
                           --disable-bluez5-ofono-headset \
                           --disable-bluez5-native-headset \
                           --enable-udev \
                           --with-udev-rules-dir=/usr/lib/udev/rules.d
                           --disable-hal-compat \
                           --enable-ipv6 \
                           --enable-openssl \
                           --disable-xen \
                           --disable-orc \
                           --disable-manpages \
                           --disable-per-user-esound-socket \
                           --disable-default-build-tests \
                           --disable-legacy-database-entry-format \
                           --with-system-user=root \
                           --with-system-group=root \
                           --with-access-group=root \
                           --without-caps \
                           --without-fftw \
                           --without-speex \
                           --with-soxr \
                           --with-module-dir=/usr/lib/pulse"

pre_configure_target()
{
  sed -e 's|; remixing-use-all-sink-channels = yes|; remixing-use-all-sink-channels = no|' \
      -i $PKG_BUILD/src/daemon/daemon.conf.in
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin/esdcompat
  rm -rf $INSTALL/usr/include
  rm -rf $INSTALL/usr/lib/cmake
  rm -rf $INSTALL/usr/lib/pkgconfig
  rm -rf $INSTALL/usr/lib/systemd
  rm -rf $INSTALL/usr/share/vala
  rm -rf $INSTALL/usr/share/zsh
  rm -rf $INSTALL/usr/share/bash-completion

  cp $PKG_DIR/config/system.pa $INSTALL/etc/pulse/
  cp $PKG_DIR/config/pulseaudio-system.conf $INSTALL/etc/dbus-1/system.d/

  mkdir -p $INSTALL/usr/config
    cp -PR $PKG_DIR/config/pulse-daemon.conf.d $INSTALL/usr/config

  ln -sf /storage/.config/pulse-daemon.conf.d $INSTALL/etc/pulse/daemon.conf.d
}

post_install() {
  enable_service pulseaudio.service
}
