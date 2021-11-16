################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="cbfstool"
PKG_VERSION="6087335b0847a66a725156e39bf1329462c03751"
PKG_GIT_CLONE_BRANCH="switch-linux"
PKG_ARCH="any"
PKG_DEPENDS_HOST="zlib:host openssl:host"
PKG_SITE="https://gitlab.com/switchroot/switch-coreboot"
PKG_GIT_URL="$PKG_SITE"
PKG_URL="https://gitlab.com/switchroot/switch-coreboot.git"
PKG_TOOLCHAIN="manual"

PKG_AUTORECONF="no"

GET_SKIP_SUBMODULE="yes"

make_host() {
  cd ${PKG_BUILD}
  git submodule update --init --recursive
  cd ${PKG_BUILD}/util/cbfstool/
  make
}

makeinstall_host() {
  if [ -f "${TOOLCHAIN}/bin/cbfstool" ]; then
    rm -r ${TOOLCHAIN}/bin/cbfstool
  fi
  mkdir -p ${INSTALL_PKG}/usr/bin
  cp -P ${PKG_BUILD}/util/cbfstool/cbfstool ${TOOLCHAIN}/bin
}

pre_make_host() {
  :
}

make_target() {
  :
}

makeinstall_target() {
  :
}
