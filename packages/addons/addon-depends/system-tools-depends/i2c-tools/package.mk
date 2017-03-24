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

PKG_NAME="i2c-tools"
PKG_VERSION="3.1.2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.lm-sensors.org/wiki/I2CTools"
PKG_URL="http://fossies.org/linux/misc/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python distutilscross:host"
PKG_SECTION="debug/tools"
PKG_SHORTDESC="i2c-tools: bus probing tool, eeprom decoding/programming and SMBus python interface"
PKG_LONGDESC="The i2c-tools package contains a heterogeneous set of I2C tools for Linux: a bus probing tool, a chip dumper, register-level SMBus access helpers, EEPROM decoding scripts, EEPROM programming tools, and a python module for SMBus access."
PKG_AUTORECONF="no"

pre_make_target() {
  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
  export LDSHARED="$CC -shared"
}

make_target() {
  make  EXTRA="py-smbus" \
        CC="$CC" \
        AR="$TARGET_AR" \
        CFLAGS="$TARGET_CFLAGS" \
        CPPFLAGS="$TARGET_CPPFLAGS -I${SYSROOT_PREFIX}/usr/include/python2.7"
}

makeinstall_target() {
  : # nop
}
