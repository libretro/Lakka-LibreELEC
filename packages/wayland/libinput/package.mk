# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="libinput"
PKG_VERSION="1.16.4"
PKG_SHA256="65923a06d5a8970e4a999c4668797b9b689614b62b1d44432ab1c87b65e39e29"
PKG_LICENSE="GPL"
PKG_SITE="http://www.freedesktop.org/wiki/Software/libinput/"
PKG_URL="http://www.freedesktop.org/software/libinput/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain systemd libevdev mtdev"
PKG_LONGDESC="libinput is a library to handle input devices in Wayland compositors and to provide a generic X.Org input driver."

PKG_MESON_OPTS_TARGET="-Dlibwacom=false \
                       -Ddebug-gui=false \
                       -Dtests=false \
                       -Ddocumentation=false"
