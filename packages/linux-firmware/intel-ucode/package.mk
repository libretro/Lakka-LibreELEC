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

PKG_NAME="intel-ucode"
PKG_VERSION="20161104"
PKG_ARCH="x86_64"
PKG_LICENSE="other"
PKG_SITE="https://downloadcenter.intel.com/search?keyword=linux+microcode"
PKG_URL="https://downloadmirror.intel.com/26400/eng/microcode-${PKG_VERSION}.tgz"
PKG_DEPENDS_TARGET="toolchain intel-ucode:host"
PKG_SECTION="linux-firmware"
PKG_SHORTDESC="intel-ucode: Intel CPU microcodes"
PKG_LONGDESC="intel-ucode: Intel CPU microcodes"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

unpack() {
  mkdir -p $PKG_BUILD
  tar xf $SOURCES/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tgz -C $PKG_BUILD
}

make_host() {
  $CC $CFLAGS -o intel-microcode2ucode intel-microcode2ucode.c
}

makeinstall_host() {
  cp intel-microcode2ucode $TOOLCHAIN/bin/
}

make_target() {
  intel-microcode2ucode ./microcode.dat
}

makeinstall_target() {
  :
}
