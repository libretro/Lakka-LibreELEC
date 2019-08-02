# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="grub"
PKG_VERSION="2.04"
PKG_SHA256="a4a065f83d23e089a8086e7d0a3f86d914f884a9732a38c9a16ae2edb427fde1"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv3"
PKG_SITE="https://www.gnu.org/software/grub/index.html"
PKG_URL="http://git.savannah.gnu.org/cgit/grub.git/snapshot/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain flex freetype:host gnulib:host"
PKG_LONGDESC="GRUB is a Multiboot boot loader."
PKG_TOOLCHAIN="configure"

pre_configure_target() {
  PKG_CONFIGURE_OPTS_TARGET="--target=i386-pc-linux \
                             --disable-nls \
                             --with-platform=efi"

  unset CFLAGS
  unset CPPFLAGS
  unset CXXFLAGS
  unset LDFLAGS
  unset CPP

  cd $PKG_BUILD
    # keep grub synced with gnulib
    ./bootstrap --gnulib-srcdir=$(get_build_dir gnulib) --copy --no-git --no-bootstrap-sync --skip-po
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
