################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
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

PKG_NAME="intel-ucode"
PKG_VERSION="20180108"
PKG_SHA256="063f1aa3a546cb49323a5e0b516894e4b040007107b8c8ff017aca8a86204130"
PKG_ARCH="x86_64"
PKG_LICENSE="other"
PKG_SITE="https://downloadcenter.intel.com/search?keyword=linux+microcode"
PKG_URL="https://downloadmirror.intel.com/27431/eng/microcode-${PKG_VERSION}.tgz"
PKG_DEPENDS_HOST="toolchain"
PKG_DEPENDS_TARGET="toolchain intel-ucode:host"
PKG_SECTION="linux-firmware"
PKG_SHORTDESC="intel-ucode: Intel CPU microcodes"
PKG_LONGDESC="intel-ucode: Intel CPU microcodes"
PKG_TOOLCHAIN="manual"

unpack() {
  mkdir -p $PKG_BUILD
  tar xf $SOURCES/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tgz -C $PKG_BUILD
}
