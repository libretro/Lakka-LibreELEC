################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
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

PKG_NAME="waylandpp"
PKG_VERSION="7ddac0a"
PKG_SHA256="490407b69a6a4927517d8901882c5e18524d969625bb5044ef4979b8fa839012"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/NilsBrause/waylandpp"
PKG_URL="https://github.com/pkerling/waylandpp/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain waylandpp:host"
PKG_PRIORITY="optional"
PKG_SECTION="wayland"
PKG_SHORTDESC="Wayland C++ bindings"
PKG_LONGDESC="Wayland C++ bindings"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CMAKE_OPTS_HOST="-DBUILD_SCANNER=ON \
                     -DBUILD_LIBRARIES=OFF"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SCANNER=OFF \
                       -DBUILD_LIBRARIES=ON \
                       -DCMAKE_CROSSCOMPILING=ON \
                       -DWAYLAND_SCANNERPP=$TOOLCHAIN/bin/wayland-scanner++"
