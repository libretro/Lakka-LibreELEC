################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017 Team LibreELEC
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

PKG_NAME="glmark2"
PKG_VERSION="182dcbf"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/glmark2/glmark2"
PKG_URL="https://github.com/glmark2/glmark2/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libjpeg-turbo libpng systemd $OPENGLES"
PKG_SECTION="graphics"
PKG_SHORTDESC="glmark2: glmark2 is an OpenGL 2.0 and ES 2.0 benchmark"
PKG_LONGDESC="glmark2: glmark2 is an OpenGL 2.0 and ES 2.0 benchmark"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$OPENGLES" = "mali-rockchip" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libdrm"
  GLMARK2_FLAVOR="--with-flavors=drm-glesv2"
elif [ "$OPENGLES" = "opengl-meson" ] || [ "$OPENGLES" == "allwinner-mali" ]; then
  GLMARK2_FLAVOR="--with-flavors=fbdev-glesv2 --for-mali"
fi

PKG_CONFIGURE_OPTS_TARGET="--prefix=/usr $GLMARK2_FLAVOR"

configure_target() {
  cd $PKG_BUILD
    LDFLAGS="-lz" ./waf configure $PKG_CONFIGURE_OPTS_TARGET
}

make_target() {
  cd $PKG_BUILD
    ./waf build
}

makeinstall_target() {
  cd $PKG_BUILD
    ./waf install --destdir=$INSTALL
}
