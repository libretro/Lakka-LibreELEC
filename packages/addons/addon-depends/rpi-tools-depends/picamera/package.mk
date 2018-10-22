# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="picamera"
PKG_VERSION="1.13"
PKG_SHA256="890815aa01e4d855a6a95dd3ad0953b872a6b954982106407df0c5a31a163e50"
PKG_ARCH="arm"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/waveform80/picamera"
PKG_URL="https://files.pythonhosted.org/packages/source/${PKG_NAME:0:1}/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python2 distutilscross:host bcm2835-driver"
PKG_LONGDESC="A python and shell interface for the Raspberry Pi camera module."
PKG_TOOLCHAIN="manual"
