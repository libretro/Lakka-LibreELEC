# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="weston"
PKG_VERSION="3.0.0"
PKG_SHA256="cde1d55e8dd70c3cbb3d1ec72f60e60000041579caa1d6a262bd9c35e93723a5"
PKG_LICENSE="OSS"
PKG_SITE="https://wayland.freedesktop.org/"
PKG_URL="https://wayland.freedesktop.org/releases/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain wayland-protocols libdrm libxkbcommon libinput cairo libjpeg-turbo dbus"
PKG_LONGDESC="Reference implementation of a Wayland compositor"

PKG_CONFIGURE_OPTS_TARGET="CFLAGS=-DMESA_EGL_NO_X11_HEADERS \
                           LIBS=-lturbojpeg \
                           --with-cairo-glesv2 \
                           --disable-xwayland \
                           --disable-x11-compositor \
                           --disable-xwayland-test \
                           --disable-libunwind \
                           --disable-colord \
                           --disable-ivi-shell \
                           --disable-fbdev-compositor \
                           --disable-rdp-compositor \
                           --disable-screen-sharing \
                           --disable-vaapi-recorder \
                           --disable-headless-compositor \
                           --enable-systemd-login \
                           --disable-weston-launch \
                           --disable-fullscreen-shell \
                           --disable-demo-clients-install \
                           --enable-systemd-notify"

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/weston
    cp $PKG_DIR/scripts/weston-config $INSTALL/usr/lib/weston

  mkdir -p $INSTALL/usr/share/weston
    cp $PKG_DIR/config/weston.ini $INSTALL/usr/share/weston

  rm -r $INSTALL/usr/share/wayland-sessions
  rm -r $INSTALL/usr/lib/weston-simple-im
}

post_install() {
  enable_service weston.service
}
