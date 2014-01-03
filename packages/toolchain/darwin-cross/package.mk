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

PKG_NAME="darwin-cross"
PKG_VERSION="1"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://gcc.gnu.org/"
PKG_URL="http://atv-bootloader.googlecode.com/files/$PKG_NAME.tar.gz"
PKG_SOURCE_DIR="$PKG_NAME"
PKG_DEPENDS=""
PKG_BUILD_DEPENDS=""
PKG_PRIORITY="optional"
PKG_SECTION="toolchain/toolchains"
PKG_SHORTDESC="darwin-cross: darwin gcc etc"
PKG_LONGDESC="This package contains the GNU Compiler Collection to build for darwin systems"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

post_unpack() {
# extract toolchain
  tar -xzf $PKG_BUILD/darwin-cross.tar.gz -C $TOOLCHAIN

# fix 'as'
  rm -rf $TOOLCHAIN/$PKG_NAME/i386-apple-darwin8/bin/as
  ln -sf ../../libexec/10.4/as/i386/as $TOOLCHAIN/$PKG_NAME/i386-apple-darwin8/bin/as
}

make_target() {
  : # nothing todo
}

makeinstall_target() {
  : # nothing todo
}

