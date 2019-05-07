################################################################################
#      This file is part of LibreELEC - http://www.libreelec.tv
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

PKG_NAME="spirv-tools"
PKG_VERSION="61dfd84"
PKG_ARCH="any"
PKG_LICENSE="Apache 2.0"
PKG_SITE="https://github.com/KhronosGroup/SPIRV-Tools"
PKG_GIT_URL="$PKG_SITE"
PKG_DEPENDS_TARGET="toolchain cmake:host Python3"
PKG_SECTION="graphics"
PKG_SHORTDESC="The SPIR-V Tools project provides an API and commands for processing SPIR-V modules."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CMAKE_OPTS_TARGET="-DSPIRV_WERROR=OFF"

pre_configure_target() {
  cd $PKG_BUILD/external
  mkdir spirv-headers
  cd spirv-headers
  git clone https://github.com/KhronosGroup/SPIRV-Headers . --depth 1
}
