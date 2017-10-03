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

PKG_NAME="weston"
PKG_VERSION="3.0.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://wayland.freedesktop.org/"
PKG_URL="http://wayland.freedesktop.org/releases/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libinput cairo-weston libjpeg-turbo wayland-protocols libdrm"
PKG_PRIORITY="optional"
PKG_SECTION="wayland"
PKG_SHORTDESC=""
PKG_LONGDESC=""

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="CFLAGS=-DMESA_EGL_NO_X11_HEADERS \
                           --disable-xwayland \
                           --disable-x11-compositor \
                           --enable-drm-compositor \
                           --disable-xwayland-test \
                           --disable-libunwind \
                           --disable-colord \
                           --disable-ivi-shell \
                           --disable-fbdev-compositor \
                           --disable-rdp-compositor \
                           --disable-screen-sharing \
                           --disable-headless-compositor \
                           --enable-systemd-login \
                           --disable-weston-launch \
                           --disable-fullscreen-shell \
                           --disable-demo-clients-install \
                           --disable-simple-egl-clients \
                           --enable-systemd-notify"

pre_configure_target() {
  export LIBS="-lturbojpeg"
}

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
