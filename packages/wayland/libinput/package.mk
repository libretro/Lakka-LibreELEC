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

PKG_NAME="libinput"
PKG_VERSION="1.10.4"
PKG_SHA256="2330a82f3e4b617a4f9ff0f2bf9cc217b3c4e69d767e61ca59ca07add61f68ac"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.freedesktop.org/wiki/Software/libinput/"
PKG_URL="http://www.freedesktop.org/software/libinput/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain systemd libevdev mtdev"
PKG_SECTION="wayland"
PKG_SHORTDESC="libinput is a library to handle input devices in Wayland compositors and to provide a generic X.Org input driver."
PKG_LONGDESC="libinput is a library to handle input devices in Wayland compositors and to provide a generic X.Org input driver."
PKG_TOOLCHAIN="meson"

PKG_MESON_OPTS_TARGET="-Dlibwacom=false \
                       -Ddebug-gui=false \
                       -Dtests=false \
                       -Ddocumentation=false"
