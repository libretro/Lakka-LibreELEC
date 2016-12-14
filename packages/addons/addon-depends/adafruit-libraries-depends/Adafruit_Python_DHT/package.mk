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

PKG_NAME="Adafruit_Python_DHT"
PKG_VERSION="310c59b"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/adafruit/${PKG_NAME}"
PKG_URL="https://github.com/adafruit/${PKG_NAME}/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python distutilscross:host"
PKG_SECTION="python"
PKG_SHORTDESC="Adafruit Python DHT Library"
PKG_LONGDESC="Python library to read the DHT series of humidity and temperature sensors on a Raspberry Pi or Beaglebone Black."
PKG_AUTORECONF="no"

case $PROJECT in
  RPi)
    RPI_VERSION="--force-pi"
    ;;
  RPi2)
    RPI_VERSION="--force-pi2"
    ;;
esac

pre_make_target() {
  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
  export LDSHARED="$CC -shared"

  sed -e 's/from ez_setup import use_setuptools/\#from ez_setup import use_setuptools/' \
      -e 's/use_setuptools()/\#use_setuptools()/' \
      -i setup.py
}

make_target() {
  python setup.py build $RPI_VERSION --cross-compile
}

makeinstall_target() {
  : # nop
}
