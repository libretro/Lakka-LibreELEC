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

PKG_NAME="atv-bootloader"
PKG_VERSION="r520"
PKG_REV="1"
PKG_ARCH="i386 x86_64"
PKG_LICENSE="GPL"
PKG_SITE="http://code.google.com/p/atv-bootloader/"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain atvboot darwin-cross linux"
PKG_PRIORITY="optional"
PKG_SECTION="tools"
PKG_SHORTDESC="atv-bootloader: Tool to create a mach_kernel compaitible kernel image"
PKG_LONGDESC="atv-bootloader which uses principals from mach_linux_boot to boot a compiled-in Linux kernel"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_MAKE_OPTS_TARGET="KERN_OBJ=vmlinuz.obj \
                      CC=$ROOT/$TOOLCHAIN/darwin-cross/bin/i386-apple-darwin8-gcc-4.0.1 \
                      LD=$ROOT/$TOOLCHAIN/darwin-cross/bin/i386-apple-darwin8-ld"

pre_make_target() {
  unset LDFLAGS

  rm -rf mach_kernel vmlinuz initrd.gz
  cp -PR $(kernel_path)/arch/x86/boot/bzImage vmlinuz

  make clean
}

makeinstall_target() {
  : # nothing todo
}
