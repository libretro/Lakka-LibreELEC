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

PKG_NAME="libva"
PKG_VERSION="2.0.0"
PKG_SHA256="bb0601f9a209e60d8d0b867067323661a7816ff429021441b775452b8589e533"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="https://01.org/linuxmedia"
PKG_URL="https://github.com/01org/libva/releases/download/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_SECTION="multimedia"
PKG_SHORTDESC="Libva is an implementation for VA-API (VIdeo Acceleration API)."
PKG_LONGDESC="Libva is an open source software library and API specification to provide access to hardware accelerated video decoding/encoding and video processing."
PKG_AUTORECONF="yes"

if [ "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET="toolchain libX11 libXext libXfixes libdrm mesa"
  DISPLAYSERVER_LIBVA="--enable-x11 --enable-glx"
else
  PKG_DEPENDS_TARGET="toolchain libdrm"
  DISPLAYSERVER_LIBVA="--disable-x11 --disable-glx"
fi

PKG_CONFIGURE_OPTS_TARGET="--disable-silent-rules \
                           --disable-docs \
                           --enable-drm \
                           --enable-egl \
                           $DISPLAYSERVER_LIBVA \
                           --disable-wayland \
                           --disable-dummy-driver"
