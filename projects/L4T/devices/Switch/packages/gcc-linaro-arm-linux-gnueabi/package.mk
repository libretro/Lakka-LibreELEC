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

PKG_NAME="gcc-linaro-arm-linux-gnueabi"
PKG_VERSION="6.4.1-2018.05"
PKG_VERSION_SHORT="6.4-2018.05"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL="https://releases.linaro.org/components/toolchain/binaries/${PKG_VERSION_SHORT}/arm-linux-gnueabi/gcc-linaro-${PKG_VERSION}-x86_64_arm-linux-gnueabi.tar.xz"
PKG_SOURCE_DIR="gcc-linaro-${PKG_VERSION}-x86_64_arm-linux-gnueabi"
PKG_PRIORITY="optional"
PKG_SECTION="lang"
PKG_SHORTDESC=""
PKG_LONGDESC=""
PKG_TOOLCHAIN="make"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_host() {
  :
}

makeinstall_host() {
  mkdir -p ${TOOLCHAIN}/lib/gcc-linaro-arm-linux-gnueabi/
  cp -a * ${TOOLCHAIN}/lib/gcc-linaro-arm-linux-gnueabi
}
