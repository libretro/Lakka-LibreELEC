################################################################################
#      This file is part of LibreELEC - https://LibreELEC.tv
#      Copyright (C) 2016 Team LibreELEC
#      Copyright (C) 2016 kszaq
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

PKG_NAME="android-headers"
PKG_VERSION="25"
PKG_ARCH="any"
PKG_LICENSE="Apache"
PKG_SITE="https://android.googlesource.com/"
PKG_URL="https://kszaq.libreelec.tv/sources/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="devel"
PKG_SHORTDESC="android-headers: Android Platform Headers from AOSP releases"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  : # nop
}

makeinstall_target() {
  : # nop
}
