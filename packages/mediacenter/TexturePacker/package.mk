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

PKG_NAME="TexturePacker"
PKG_VERSION="0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kodi.tv"
PKG_URL=""
PKG_DEPENDS_HOST="lzo:host libpng:host libjpeg-turbo:host giflib:host"
PKG_NEED_UNPACK="$ROOT/packages/mediacenter/$MEDIACENTER/package.mk"
PKG_SECTION="mediacenter"
PKG_SHORTDESC="kodi-platform:"
PKG_LONGDESC="kodi-platform:"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CMAKE_SCRIPT="$(get_build_dir $MEDIACENTER)/tools/depends/native/TexturePacker/CMakeLists.txt"

PKG_CMAKE_OPTS_HOST="-Wno-dev"

pre_build_host() {
  $SCRIPTS/clean $PKG_NAME
}

pre_configure_host() {
  export CXXFLAGS="$CXXFLAGS -std=c++11 -DTARGET_POSIX -DTARGET_LINUX -D_LINUX -I$(get_build_dir $MEDIACENTER)/xbmc/linux"
}

makeinstall_host() {
  mkdir -p $TOOLCHAIN/bin
    cp TexturePacker $TOOLCHAIN/bin
}
