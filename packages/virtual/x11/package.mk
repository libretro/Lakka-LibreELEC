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

PKG_NAME="x11"
PKG_VERSION=""
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain xorg-server"
PKG_PRIORITY="optional"
PKG_SECTION="virtual"
PKG_SHORTDESC="x11: the Windowing system"
PKG_LONGDESC="X11 is the Windowing system"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

# Additional packages we need for using xorg-server:
# Fonts
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET encodings font-xfree86-type1 font-bitstream-type1 font-misc-misc"

# Server
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET xkeyboard-config xkbcomp"

# Tools
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET xrandr setxkbmap"

if [ -n "$WINDOWMANAGER" -a "$WINDOWMANAGER" != "none" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $WINDOWMANAGER"
fi

get_graphicdrivers
# Drivers
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET xf86-input-evdev"
  for drv in $XORG_DRIVERS; do
    PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET xf86-video-$drv"
  done
