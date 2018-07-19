# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="Adafruit_Python_PureIO"
PKG_VERSION="5e952c2"
PKG_SHA256="53faa8629802fad6e8b7bdc434b6cef5f81cb84541564a193e26f334e5b4aa7d"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/adafruit/${PKG_NAME}"
PKG_URL="https://github.com/adafruit/${PKG_NAME}/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python2 distutilscross:host"
PKG_SECTION="python"
PKG_SHORTDESC="Pure python access to Linux IO including I2C and SPI."
PKG_LONGDESC="Pure python access to Linux IO including I2C and SPI. Drop in replacement for smbus and spidev modules."
PKG_TOOLCHAIN="manual"
