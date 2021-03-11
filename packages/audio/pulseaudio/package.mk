# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pulseaudio"
PKG_VERSION="14.2"
PKG_SHA256="75d3f7742c1ae449049a4c88900e454b8b350ecaa8c544f3488a2562a9ff66f1"
PKG_LICENSE="GPL"
PKG_SITE="http://pulseaudio.org/"
PKG_URL="http://www.freedesktop.org/software/pulseaudio/releases/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain alsa-lib dbus libcap libsndfile libtool openssl soxr speexdsp systemd glib:host glib"
PKG_LONGDESC="PulseAudio is a sound system for POSIX OSes, meaning that it is a proxy for your sound applications."
PKG_TOOLCHAIN="meson"

if [ "${BLUETOOTH_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" sbc"
  PKG_PULSEAUDIO_BLUETOOTH="-Dbluez5=true"
else
  PKG_PULSEAUDIO_BLUETOOTH="-Dbluez5=false"
fi

if [ "${AVAHI_DAEMON}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" avahi"
  PKG_PULSEAUDIO_AVAHI="-Davahi=enabled"
else
  PKG_PULSEAUDIO_AVAHI="-Davahi=disabled"
fi

PKG_MESON_OPTS_TARGET="-Dgcov=false \
                       -Dman=false \
                       -Dtests=false \
                       -Dsystem_user=root \
                       -Dsystem_group=root \
                       -Daccess_group=root \
                       -Ddatabase=simple \
                       -Dlegacy-database-entry-format=false \
                       -Drunning-from-build-tree=false \
                       -Datomic-arm-linux-helpers=true \
                       -Datomic-arm-memory-barrier=false \
                       -Dmodlibexecdir=/usr/lib/pulse \
                       -Dudevrulesdir=/usr/lib/udev/rules.d \
                       -Dalsa=enabled \
                       -Dasyncns=disabled \
                       ${PKG_PULSEAUDIO_AVAHI} \
                       ${PKG_PULSEAUDIO_BLUETOOTH} \
                       -Dbluez5-native-headset=false \
                       -Dbluez5-ofono-headset=false \
                       -Ddbus=enabled \
                       -Dfftw=disabled \
                       -Dglib=enabled \
                       -Dgsettings=disabled \
                       -Dgtk=disabled \
                       -Dhal-compat=false \
                       -Dipv6=true \
                       -Djack=disabled \
                       -Dlirc=disabled \
                       -Dopenssl=enabled \
                       -Dorc=disabled \
                       -Dsamplerate=disabled \
                       -Dsoxr=enabled \
                       -Dspeex=enabled \
                       -Dsystemd=enabled \
                       -Dudev=enabled \
                       -Dx11=disabled \
                       -Dadrian-aec=true \
                       -Dwebrtc-aec=disabled"

pre_configure_target() {
  sed -e 's|; remixing-use-all-sink-channels = yes|; remixing-use-all-sink-channels = no|' \
      -i ${PKG_BUILD}/src/daemon/daemon.conf.in
}

post_makeinstall_target() {
  safe_remove ${INSTALL}/usr/include
  safe_remove ${INSTALL}/usr/lib/cmake
  safe_remove ${INSTALL}/usr/lib/pkgconfig
  safe_remove ${INSTALL}/usr/lib/systemd
  safe_remove ${INSTALL}/usr/share/vala
  safe_remove ${INSTALL}/usr/share/zsh
  safe_remove ${INSTALL}/usr/share/bash-completion

  cp ${PKG_DIR}/config/system.pa ${INSTALL}/etc/pulse/

  sed 's/user="pulse"/user="root"/' -i ${INSTALL}/etc/dbus-1/system.d/pulseaudio-system.conf

  mkdir -p ${INSTALL}/usr/config
    cp -PR ${PKG_DIR}/config/pulse-daemon.conf.d ${INSTALL}/usr/config

  ln -sf /storage/.config/pulse-daemon.conf.d ${INSTALL}/etc/pulse/daemon.conf.d
}

post_install() {
  enable_service pulseaudio.service
}
