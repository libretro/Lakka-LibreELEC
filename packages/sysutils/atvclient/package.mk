# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="atvclient"
PKG_VERSION="0263b0a"
PKG_SHA256="9f741cf36655736ef578eaaca615fd9ce10e290f956cebcff3316d77152f0761"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://github.com/Evinyatar/atvclient/wiki"
PKG_URL="https://github.com/Evinyatar/atvclient/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="atvclient-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain libusb-compat"
PKG_SECTION="system/remote"
PKG_SHORTDESC="atvclient: a background application for Linux that reads input from the AppleTV’s internal infra-red receiver"
PKG_LONGDESC="atvclient is a background application for Linux that reads input from the AppleTV’s internal infra-red receiver and submits it to XBMC in a way very similar to how XBMCHelper does this under the native AppleTV OS. It implements most of the functionality the ATV OS HID driver supports, including pairing and control of the status LED."
