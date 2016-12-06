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

PKG_NAME="vboxguest"
PKG_VERSION="5.1.8"
PKG_REV="1"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="http://www.virtualbox.org"
PKG_URL="http://download.virtualbox.org/virtualbox/$PKG_VERSION/VirtualBox-$PKG_VERSION.tar.bz2"
PKG_SOURCE_DIR="VirtualBox-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="driver"
PKG_SHORTDESC="vboxguest"
PKG_LONGDESC="vboxguest"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_configure_target() {
  # Create and unpack a tarball with the sources of the Linux guest
  # kernel modules, to include all the needed files
  mkdir -p $ROOT/$PKG_BUILD/vbox-kmod
  $ROOT/$PKG_BUILD/src/VBox/Additions/linux/export_modules $ROOT/$PKG_BUILD/vbox-kmod/vbox-kmod.tar.gz
  tar -xf $ROOT/$PKG_BUILD/vbox-kmod/vbox-kmod.tar.gz -C $ROOT/$PKG_BUILD/vbox-kmod
}

configure_target() {
  :
}

make_target() {
  cd $ROOT/$PKG_BUILD/vbox-kmod
  make KERN_DIR=$(kernel_path)
}

makeinstall_target() {
  for module in vboxguest vboxsf vboxvideo; do
    mkdir -p $INSTALL/usr/lib/modules/$(get_module_dir)/$module
      cp -P $ROOT/$PKG_BUILD/vbox-kmod/$module.ko $INSTALL/usr/lib/modules/$(get_module_dir)/$module
  done
}
