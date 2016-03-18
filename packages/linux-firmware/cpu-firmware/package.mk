################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="cpu-firmware"
PKG_VERSION="9885c9c"
PKG_REV="1"
PKG_ARCH="i386 x86_64"
PKG_LICENSE="other"
PKG_SITE="https://git.fedorahosted.org/cgit/microcode_ctl.git/"
PKG_GIT_URL="https://github.com/OpenELEC/cpu-firmware.git"
PKG_GIT_BRANCH="master"
PKG_DEPENDS_INIT="toolchain"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="linux-firmware"
PKG_SHORTDESC="cpu-microcode: Intel and AMD CPU microcodes"
PKG_LONGDESC="cpu-microcode: Intel and AMD CPU microcodes"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_init() {
  : # nothing todo
}

makeinstall_init() {
  DESTDIR=$INSTALL ./install
}

make_target() {
  : # nothing todo
}

makeinstall_target() {
  DESTDIR=$INSTALL ./install
}
