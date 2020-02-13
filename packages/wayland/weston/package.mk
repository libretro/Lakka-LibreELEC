# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="weston"
PKG_VERSION="6.0.0"
PKG_LICENSE="OSS"
PKG_SITE="https://wayland.freedesktop.org/"
PKG_URL="https://wayland.freedesktop.org/releases/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain wayland-protocols libdrm libxkbcommon libinput cairo libjpeg-turbo dbus"
PKG_LONGDESC="Reference implementation of a Wayland compositor"

PKG_TOOLCHAIN="configure"

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
                           --enable-systemd-notify \
                           --enable-autotools"

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/weston
    cp $PKG_DIR/scripts/weston-config $INSTALL/usr/lib/weston

  mkdir -p $INSTALL/usr/share/weston
    if [ -f $PKG_DIR/config/$DEVICE.ini ]; then
      cp $PKG_DIR/config/$DEVICE.ini $INSTALL/usr/share/weston/weston.ini
    else
      cp $PKG_DIR/config/weston.ini $INSTALL/usr/share/weston
    fi

  rm -r $INSTALL/usr/share/wayland-sessions
  rm -r $INSTALL/usr/lib/weston-simple-im
}

post_install() {
  enable_service weston.service
}
