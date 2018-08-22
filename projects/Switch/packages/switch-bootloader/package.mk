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

PKG_NAME="switch-bootloader"
PKG_VERSION="1.0"
PKG_ARCH="any"
PKG_DEPENDS_TARGET="switch-coreboot"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/bootloader/boot
  mkimage -A arm -T script -O linux -d $PKG_DIR/assets/boot.txt $BUILD/$PKG_NAME-$PKG_VERSION/boot.scr
  
  cp -PRv $PKG_DIR/assets/splash.bmp $INSTALL/usr/share/bootloader/boot/splash.bmp
  cp -PRv $PKG_DIR/assets/00-Lakka.ini $INSTALL/usr/share/bootloader/boot/00-Lakka.ini
  cp -PRv $BUILD/$PKG_NAME-$PKG_VERSION/boot.scr $INSTALL/usr/share/bootloader/boot/boot.scr
  cp -PRv $BUILD/switch-boot/coreboot.rom $INSTALL/usr/share/bootloader/boot/coreboot.rom
  cp -PRv $(kernel_path)/arch/arm64/boot/dts/nvidia/tegra210-nintendo-switch.dtb $INSTALL/usr/share/bootloader/boot/tegra210-nintendo-switch.dtb
}

make_target() {
  :
}
