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

PKG_NAME="syslinux"
PKG_VERSION="6.02"
PKG_REV="1"
PKG_ARCH="i386 x86_64"
PKG_LICENSE="GPL"
PKG_SITE="http://syslinux.zytor.com/"
PKG_URL="http://www.kernel.org/pub/linux/utils/boot/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_HOST="util-linux:host"
PKG_DEPENDS_TARGET="toolchain util-linux e2fsprogs syslinux:host"
PKG_PRIORITY="optional"
PKG_SECTION="tools"
PKG_SHORTDESC="syslinux: Linux bootloader collection"
PKG_LONGDESC="The SYSLINUX project covers lightweight linux bootloaders for floppy media (syslinux), network booting (pxelinux) and bootable el-torito cd-roms (isolinux)."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_MAKE_OPTS_TARGET="CC=$CC AR=$AR RANLIB=$RANLIB installer"

# Unset all compiler FLAGS
  unset CFLAGS
  unset CPPFLAGS
  unset CXXFLAGS
  unset LDFLAGS

pre_build_target() {
  mkdir -p $PKG_BUILD/.$TARGET_NAME
  cp -RP $PKG_BUILD/* $PKG_BUILD/.$TARGET_NAME
}

pre_build_host() {
  mkdir -p $PKG_BUILD/.$HOST_NAME
  cp -RP $PKG_BUILD/* $PKG_BUILD/.$HOST_NAME
}

pre_make_target() {
  cd .$TARGET_NAME
}

pre_make_host() {
  cd .$HOST_NAME
}

make_host() {
  make CC=$CC \
       AR=$AR \
       RANLIB=$RANLIB \
       CFLAGS="-I$ROOT/$TOOLCHAIN/include -I$ROOT/$PKG_BUILD/libinstaller -I$ROOT/$PKG_BUILD/libfat -I$ROOT/$PKG_BUILD/bios -I$ROOT/$PKG_BUILD/utils -fomit-frame-pointer -D_FILE_OFFSET_BITS=64" \
       LDFLAGS="-L$ROOT/$TOOLCHAIN/lib" \
       installer
}

makeinstall_host() {
  mkdir -p $ROOT/$TOOLCHAIN/bin
    cp bios/extlinux/extlinux $ROOT/$TOOLCHAIN/bin
    cp bios/linux/syslinux $ROOT/$TOOLCHAIN/bin

  mkdir -p $ROOT/$TOOLCHAIN/share/syslinux
    cp bios/com32/menu/vesamenu.c32 $ROOT/$TOOLCHAIN/share/syslinux
    cp bios/com32/lib/libcom32.c32 $ROOT/$TOOLCHAIN/share/syslinux
    cp bios/com32/libutil/libutil.c32 $ROOT/$TOOLCHAIN/share/syslinux
    cp bios/mbr/mbr.bin $ROOT/$TOOLCHAIN/share/syslinux
    cp bios/mbr/gptmbr.bin $ROOT/$TOOLCHAIN/share/syslinux
    cp efi64/efi/syslinux.efi $ROOT/$TOOLCHAIN/share/syslinux/bootx64.efi
    cp efi64/com32/elflink/ldlinux/ldlinux.e64  $ROOT/$TOOLCHAIN/share/syslinux
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp bios/extlinux/extlinux $INSTALL/usr/bin
    cp bios/linux/syslinux $INSTALL/usr/bin

  $STRIP $INSTALL/usr/bin/syslinux
  $STRIP $INSTALL/usr/bin/extlinux

  mkdir -p $INSTALL/usr/share/syslinux
    cp bios/mbr/mbr.bin $INSTALL/usr/share/syslinux
    cp bios/mbr/gptmbr.bin $INSTALL/usr/share/syslinux
    cp efi64/efi/syslinux.efi $INSTALL/usr/share/syslinux/bootx64.efi
    cp efi64/com32/elflink/ldlinux/ldlinux.e64  $INSTALL/usr/share/syslinux
}
