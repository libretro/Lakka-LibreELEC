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

PKG_NAME="gcc-linaro-aarch64-linux-gnu"
PKG_VERSION="7.1.1-2017.08"
PKG_SHA256="cc61203bb1bab9b51e9631dce803be7c00b814577fd7a118113a83448bf6a833"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL="https://releases.linaro.org/components/toolchain/binaries/7.1-2017.08/aarch64-linux-gnu/gcc-linaro-${PKG_VERSION}-x86_64_aarch64-linux-gnu.tar.xz"
PKG_SOURCE_DIR="gcc-linaro-${PKG_VERSION}-x86_64_aarch64-linux-gnu"
PKG_SECTION="lang"
PKG_SHORTDESC="Linaro Aarch64 GNU Linux Binary Toolchain"
PKG_AUTORECONF="no"

make_host() {
  :
}

makeinstall_host() {
  mkdir -p $TOOLCHAIN/lib/gcc-linaro-aarch64-linux-gnu/
    cp -a * $TOOLCHAIN/lib/gcc-linaro-aarch64-linux-gnu
}
