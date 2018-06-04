################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="pulseaudio"
PKG_VERSION="11.1"
PKG_SHA256="f2521c525a77166189e3cb9169f75c2ee2b82fa3fcf9476024fbc2c3a6c9cd9e"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://pulseaudio.org/"
PKG_URL="http://www.freedesktop.org/software/pulseaudio/releases/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain alsa-lib dbus libcap libsndfile libtool openssl soxr systemd"
PKG_SECTION="audio"
PKG_LONGDESC="PulseAudio is a sound system for POSIX OSes, meaning that it is a proxy for your sound applications."

if [ "$BLUETOOTH_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET sbc"
  PKG_PULSEAUDIO_BLUETOOTH="--enable-bluez5"
else
  PKG_PULSEAUDIO_BLUETOOTH="--disable-bluez5"
fi

if [ "$AVAHI_DAEMON" = "yes" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET avahi"
  PKG_PULSEAUDIO_AVAHI="--enable-avahi"
else
  PKG_PULSEAUDIO_AVAHI="--disable-avahi"
fi

# PulseAudio fails to build on aarch64 when NEON is enabled, so don't enable NEON for aarch64 until upstream supports it
if [ "$TARGET_ARCH" = "arm" ] && target_has_feature neon; then
  PKG_PULSEAUDIO_NEON="--enable-neon-opt"
else
  PKG_PULSEAUDIO_NEON="--disable-neon-opt"
fi

PKG_CONFIGURE_OPTS_TARGET="--disable-silent-rules \
                           --disable-nls \
                           --enable-largefile \
                           --disable-rpath \
                           $PKG_PULSEAUDIO_NEON \
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
                           $PKG_PULSEAUDIO_AVAHI \
                           --disable-jack \
                           --disable-asyncns \
                           --disable-tcpwrap \
                           --disable-lirc \
                           --enable-dbus \
                           --disable-bluez4 \
                           $PKG_PULSEAUDIO_BLUETOOTH \
                           --disable-bluez5-ofono-headset \
                           --disable-bluez5-native-headset \
                           --enable-udev \
                           --with-udev-rules-dir=/usr/lib/udev/rules.d \
                           --disable-hal-compat \
                           --enable-ipv6 \
                           --enable-openssl \
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
