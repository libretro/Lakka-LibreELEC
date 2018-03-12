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

PKG_NAME="grub"
PKG_VERSION="2.02"
PKG_SHA256="4ff6999add483bf640e130bc076ca1464901b4677ee01297901b40fe55de03c4"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv3"
PKG_SITE="https://www.gnu.org/software/grub/index.html"
PKG_URL="http://git.savannah.gnu.org/cgit/grub.git/snapshot/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain flex freetype:host"
PKG_SECTION="tools"
PKG_SHORTDESC="GNU GRUB is a Multiboot boot loader."
PKG_LONGDESC="GNU GRUB is a Multiboot boot loader that was derived from GRUB, the GRand Unified Bootloader, which was originally designed and implemented by Erich Stefan Boleyn"
PKG_TOOLCHAIN="configure"
PKG_BUILD_FLAGS="-lto"

PKG_CONFIGURE_OPTS_TARGET="--target=i386-pc-linux \
                           --disable-nls \
                           --with-platform=efi"

  unset CFLAGS
  unset CPPFLAGS
  unset CXXFLAGS
  unset LDFLAGS

pre_configure_target() {
  unset CPP
  cd $PKG_BUILD
     ./autogen.sh
}

make_target() {
  make CC=$CC \
       AR=$AR \
       RANLIB=$RANLIB \
       CFLAGS="-I$SYSROOT_PREFIX/usr/include -fomit-frame-pointer -D_FILE_OFFSET_BITS=64" \
       LDFLAGS="-L$SYSROOT_PREFIX/usr/lib"
}

makeinstall_target() {
  cd $PKG_BUILD/grub-core
     $PKG_BUILD/grub-mkimage -d . -o bootia32.efi -O i386-efi -p /EFI/BOOT \
                                boot chain configfile ext2 fat linux search \
                                efi_gop efi_uga part_gpt gzio \
                                gettext loadenv loadbios memrw

  mkdir -p $INSTALL/usr/share/grub
     cp -P $PKG_BUILD/grub-core/bootia32.efi $INSTALL/usr/share/grub

  mkdir -p $TOOLCHAIN/share/grub
     cp -P $PKG_BUILD/grub-core/bootia32.efi $TOOLCHAIN/share/grub
}
