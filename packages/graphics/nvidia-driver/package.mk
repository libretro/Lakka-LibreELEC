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

PKG_NAME="nvidia-driver"
PKG_VERSION="390.42"
PKG_ARCH="x86_64"
PKG_LICENSE="nonfree"
PKG_SITE="http://www.nvidia.com/"
PKG_URL="http://us.download.nvidia.com/XFree86/Linux-x86_64/$PKG_VERSION/NVIDIA-Linux-x86_64-$PKG_VERSION-no-compat32.run"
PKG_DEPENDS_TARGET="toolchain util-macros linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="graphics"
PKG_SHORTDESC="nvidia-driver: The driver for NVIDIA video chips"
PKG_LONGDESC="The driver for NVIDIA video chips"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

unpack() {
  [ -d $PKG_BUILD ] && rm -rf $PKG_BUILD

  sh $SOURCES/$PKG_NAME/$PKG_SOURCE_NAME --extract-only --target $PKG_BUILD
}

make_target() {
  unset LDFLAGS

  cd kernel
    make module CC=$CC SYSSRC=$(kernel_path) SYSOUT=$(kernel_path)
    $STRIP --strip-debug nvidia.ko
  cd ..
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib
    cp -P lib*so* $INSTALL/usr/lib
    cp -P tls/libnvidia-tls.so.$PKG_VERSION $INSTALL/usr/lib

  mkdir -p $INSTALL/$(get_full_module_dir)/nvidia
    cp -P kernel/nvidia.ko $INSTALL/$(get_full_module_dir)/nvidia
    cp -P kernel/nvidia-uvm.ko $INSTALL/$(get_full_module_dir)/nvidia
    cp -P kernel/nvidia-modeset.ko $INSTALL/$(get_full_module_dir)/nvidia

  mkdir -p $INSTALL/usr/bin
    cp -P nvidia-smi $INSTALL/usr/bin
}
