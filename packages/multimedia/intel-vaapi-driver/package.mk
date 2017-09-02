################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017-present Team LibreELEC
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

PKG_NAME="intel-vaapi-driver"
PKG_VERSION="1.8.3"
PKG_SHA256="54411d9e579300ed63f8b9b06152a1a9ec95b7699507d7ffa014cd7b2aeaff6f"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="https://01.org/linuxmedia"
PKG_URL="https://github.com/01org/intel-vaapi-driver/releases/download/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libva libdrm"
PKG_SECTION="multimedia"
PKG_SHORTDESC="intel-vaapi-driver: VA-API user mode driver for Intel GEN Graphics family"
PKG_LONGDESC="intel-vaapi-driver: VA-API user mode driver for Intel GEN Graphics family"

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

if [ "$DISPLAYSERVER" = "x11" ]; then
  DISPLAYSERVER_LIBVA="--enable-x11"
else
  DISPLAYSERVER_LIBVA="--disable-x11"
fi

PKG_CONFIGURE_OPTS_TARGET="--disable-silent-rules \
                           --enable-drm \
                           --disable-wayland \
                           $DISPLAYSERVER_LIBVA"
