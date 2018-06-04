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

PKG_NAME="gcc-linaro-arm-linux-gnuebihf"
PKG_VERSION="7.2.1-2017.11"
PKG_SHA256="72919a3a99d4e28309bc8b0e615f44c65824ef012de50db3ffe9a34776e6f510"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL="https://releases.linaro.org/components/toolchain/binaries/7.2-2017.11/arm-linux-gnueabihf/gcc-linaro-7.2.1-2017.11-i686_arm-linux-gnueabihf.tar.xz"
PKG_SOURCE_DIR="gcc-linaro-$PKG_VERSION-i686_arm-linux-gnueabihf"
PKG_DEPENDS_HOST="ccache:host"
PKG_SECTION="lang"
PKG_LONGDESC="Linaro ARMv8 GNU Linux Binary Toolchain"
PKG_TOOLCHAIN="manual"

makeinstall_host() {
  mkdir -p $TOOLCHAIN/lib/gcc-linaro-arm-linux-gnuebihf/
    cp -a * $TOOLCHAIN/lib/gcc-linaro-arm-linux-gnuebihf

  # wrap gcc and g++ with ccache like in gcc package.mk
  PKG_GCC_PREFIX="$TOOLCHAIN/lib/gcc-linaro-arm-linux-gnuebihf/bin/arm-linux-gnueabihf-"

  cp "${PKG_GCC_PREFIX}gcc" "${PKG_GCC_PREFIX}gcc.real"
cat > "${PKG_GCC_PREFIX}gcc" << EOF
#!/bin/sh
$TOOLCHAIN/bin/ccache ${PKG_GCC_PREFIX}gcc.real "\$@"
EOF

  chmod +x "${PKG_GCC_PREFIX}gcc"

  cp "${PKG_GCC_PREFIX}g++" "${PKG_GCC_PREFIX}g++.real"
cat > "${PKG_GCC_PREFIX}g++" << EOF
#!/bin/sh
$TOOLCHAIN/bin/ccache ${PKG_GCC_PREFIX}g++.real "\$@"
EOF

  chmod +x "${PKG_GCC_PREFIX}g++"
}
