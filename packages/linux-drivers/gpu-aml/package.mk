################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
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

PKG_NAME="gpu-aml"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="http://openlinux.amlogic.com:8000/download/ARM/gpu/"
# r5p1
PKG_VERSION="9b0fbbc"
PKG_SHA256="7ca380052b285598f1c0100cec3411f69674dcfc0f78bc2dbe407aaf85b8ebd7"
PKG_URL="https://github.com/openwetek/gpu-aml/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="gpu-aml-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="driver"
PKG_SHORTDESC="gpu-aml: Linux drivers for Mali GPUs found in Amlogic Meson SoCs"
PKG_LONGDESC="gpu-aml: Linux drivers for Mali GPUs found in Amlogic Meson SoCs"
PKG_AUTORECONF="no"
PKG_IS_KERNEL_PKG="yes"

make_target() {
  LDFLAGS="" make -C $(kernel_path) M=$PKG_BUILD/mali \
    CONFIG_MALI400=m CONFIG_MALI450=m
}

makeinstall_target() {
  LDFLAGS="" make -C $(kernel_path) M=$PKG_BUILD/mali \
    INSTALL_MOD_PATH=$INSTALL/$(get_kernel_overlay_dir) INSTALL_MOD_STRIP=1 DEPMOD=: \
  modules_install
}
