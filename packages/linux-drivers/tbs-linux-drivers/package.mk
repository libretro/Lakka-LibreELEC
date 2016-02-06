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

PKG_NAME="tbs-linux-drivers"
PKG_VERSION="160126"
PKG_REV="1"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="http://www.tbsdtv.com/english/Download.html"
PKG_URL="http://www.tbsdtv.com/download/document/common/tbs-linux-drivers_v${PKG_VERSION}.zip"
PKG_SOURCE_DIR="$PKG_NAME"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_PRIORITY="optional"
PKG_SECTION="driver"
PKG_SHORTDESC="Linux TBS tuner drivers"
PKG_LONGDESC="Linux TBS tuner drivers"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

post_unpack() {
  tar xjf $ROOT/$PKG_BUILD/linux-tbs-drivers.tar.bz2 -C $ROOT/$PKG_BUILD
  chmod -R u+rwX $ROOT/$PKG_BUILD/linux-tbs-drivers/*
}

make_target() {
  cd $ROOT/$PKG_BUILD/linux-tbs-drivers
  ./v4l/tbs-x86_64.sh
  LDFLAGS="" make DIR=$(kernel_path) prepare
  LDFLAGS="" make DIR=$(kernel_path)
}

makeinstall_target() {
  mkdir -p $INSTALL/lib/modules/$(get_module_dir)/updates/tbs
  find $ROOT/$PKG_BUILD/linux-tbs-drivers/ -name \*.ko -exec cp {} $INSTALL/lib/modules/$(get_module_dir)/updates/tbs \;
  mkdir -p $INSTALL/lib/firmware/
  cp $ROOT/$PKG_BUILD/*.fw $INSTALL/lib/firmware/
}
