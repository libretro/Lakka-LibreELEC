# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="Adafruit_Python_DHT"
PKG_VERSION="a609d7d"
PKG_SHA256="820025c19ce9f3e59fa6d389c860eb567d5a665a08ec45e237839ca214b97615"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/adafruit/${PKG_NAME}"
PKG_URL="https://github.com/adafruit/${PKG_NAME}/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python2 distutilscross:host"
PKG_SECTION="python"
PKG_SHORTDESC="Adafruit Python DHT Library"
PKG_LONGDESC="Python library to read the DHT series of humidity and temperature sensors on a Raspberry Pi or Beaglebone Black."
PKG_TOOLCHAIN="manual"

pre_make_target() {
  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
  export LDSHARED="$CC -shared"
}

make_target() {
  case "$PROJECT:$DEVICE" in
    "RPi:RPi")
      PKG_RPI_VERSION="--force-pi"
      ;;
    "RPi:RPi2")
      PKG_RPI_VERSION="--force-pi2"
      ;;
    *)
      PKG_RPI_VERSION=""
  esac

  python setup.py build $PKG_RPI_VERSION --cross-compile
}
