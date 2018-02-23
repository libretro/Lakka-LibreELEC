################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
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

PKG_NAME="vdr-plugin-xmltv2vdr"
PKG_VERSION="ec7bd92"
PKG_SHA256="eacc91062095563d8adc93873b373ddb34b076a8c0a9e5a86f6220d1d5d892e9"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://projects.vdr-developer.org/projects/plg-xmltv2vdr"
PKG_URL="https://github.com/vdr-projects/vdr-plugin-xmltv2vdr/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain vdr sqlite curl libzip libxml2 libxslt enca pcre"
PKG_SECTION="multimedia"
PKG_SHORTDESC="xmltv2vdr imports data in xmltv format"
PKG_LONGDESC="xmltv2vdr imports data in xmltv format"
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="+pic"

pre_configure_target() {
  export CXXFLAGS="$CXXFLAGS -Wno-narrowing"
  export LIBS="-L$SYSROOT_PREFIX/usr/lib/iconv -lpcre -lpcrecpp"
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
}
