################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2018-present Team LibreELEC
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

PKG_NAME="libva"
PKG_VERSION="2.2.0"
PKG_SHA256="327181061056b49f8f9b5c5ee08fdd9832df06f4282451b218d1d0bde26a99b7"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="https://01.org/linuxmedia"
PKG_URL="https://github.com/intel/libva/archive/$PKG_VERSION.tar.gz"
PKG_SECTION="multimedia"
PKG_SHORTDESC="Libva is an implementation for VA-API (VIdeo Acceleration API)."
PKG_LONGDESC="Libva is an open source software library and API specification to provide access to hardware accelerated video decoding/encoding and video processing."
PKG_TOOLCHAIN="autotools"

if [ "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET="toolchain libX11 libXext libXfixes libdrm"
  DISPLAYSERVER_LIBVA="--enable-x11 --disable-glx --disable-wayland"
elif [ "$DISPLAYSERVER" = "weston" ]; then
  DISPLAYSERVER_LIBVA="--disable-x11 --disable-glx --enable-wayland"
  PKG_DEPENDS_TARGET="toolchain libdrm wayland"
else
  PKG_DEPENDS_TARGET="toolchain libdrm"
  DISPLAYSERVER_LIBVA="--disable-x11 --disable-glx --disable-wayland"
fi

PKG_CONFIGURE_OPTS_TARGET="--disable-silent-rules \
                           --disable-docs \
                           --enable-drm \
                           $DISPLAYSERVER_LIBVA"
