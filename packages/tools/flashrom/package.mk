################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="flashrom"
PKG_VERSION="0.9.6"
PKG_REV="1"
PKG_ARCH="i386 x86_64"
PKG_LICENSE="GPL"
PKG_SITE="http://www.flashrom.org"
PKG_URL="http://download.flashrom.org/releases/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain zlib pciutils libftdi"
PKG_PRIORITY="optional"
PKG_SECTION="tools"
PKG_SHORTDESC="flashrom: linux BIOS programmer"
PKG_LONGDESC="flashrom is a utility for identifying, reading, writing, verifying and erasing flash chips. It is designed to flash BIOS/EFI/coreboot/firmware/optionROM images on mainboards, network/graphics/storage controller cards, and various programmer devices."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_MAKE_OPTS_TARGET="CC=$TARGET_CC STRIP=$STRIP PREFIX=/usr WARNERROR=no"
PKG_MAKEINSTALL_OPTS_TARGET="CC=$TARGET_CC STRIP=$STRIP PREFIX=/usr WARNERROR=no"
