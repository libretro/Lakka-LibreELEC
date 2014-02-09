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

PKG_NAME="vdr-plugin-xmltv2vdr"
PKG_VERSION="30903cc0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://projects.vdr-developer.org/projects/plg-xmltv2vdr"
PKG_URL="http://projects.vdr-developer.org/git/vdr-plugin-xmltv2vdr.git/snapshot/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain vdr sqlite curl libzip libxml2 libxslt enca pcre"
PKG_PRIORITY="optional"
PKG_SECTION="multimedia"
PKG_SHORTDESC="vdr-xmltv2vdr"
PKG_LONGDESC="vdr-xmltv2vdr"

PKG_IS_ADDON="no"

PKG_AUTORECONF="no"

pre_configure_target() {
  export CFLAGS="$CFLAGS -fPIC"
  export CXXFLAGS="$CXXFLAGS -fPIC"
  export LDFLAGS="$LDFLAGS -fPIC"
}

make_target() {
  VDR_DIR=$(get_build_dir vdr)
  make VDRDIR=$VDR_DIR \
    LIBDIR="." \
    LOCALEDIR="./locale"
}

post_make_target() {
  cd dist/epgdata2xmltv
  make -j1
  cd -
  $STRIP dist/epgdata2xmltv/epgdata2xmltv
  $STRIP libvdr-*.so*
}

makeinstall_target() {
  : # installation not needed, done by create-addon script
}
