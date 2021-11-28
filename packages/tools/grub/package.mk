# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="grub"
PKG_VERSION="ae94b97be2b81b625d6af6654d3ed79078b50ff6" # 2021-06-08
PKG_SHA256="13dbbeeb2c16505eb7b518037a7f4ecbb6383ed286676029b0826d3f52be87f9"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv3"
PKG_SITE="https://www.gnu.org/software/grub/index.html"
PKG_URL="http://git.savannah.gnu.org/cgit/grub.git/snapshot/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain flex freetype:host gettext:host"
PKG_DEPENDS_TARGET="${PKG_NAME}:host"
PKG_DEPENDS_UNPACK="gnulib"
PKG_LONGDESC="GRUB is a Multiboot boot loader."
PKG_TOOLCHAIN="manual"

configure_host() {
  for _grub_target in x86_64-pc-linux i386-pc-linux ; do

    mkdir -p ${PKG_BUILD}/.${_grub_target}
      cp -RP ${PKG_BUILD}/* ${PKG_BUILD}/.${_grub_target}

    PKG_CONFIGURE_OPTS_HOST="--target=${_grub_target} \
                             --disable-nls \
                             --with-platform=efi"

    unset CFLAGS
    unset CPPFLAGS
    unset CXXFLAGS
    unset LDFLAGS
    unset CPP

    (
      cd ${PKG_BUILD}/.${_grub_target}
        # keep grub synced with gnulib
        ./bootstrap --gnulib-srcdir=$(get_build_dir gnulib) --copy --no-git --no-bootstrap-sync --skip-po
        ./configure ${HOST_CONFIGURE_OPTS} ${PKG_CONFIGURE_OPTS_HOST}
    )

  done
}

make_host() {
  for _grub_target in x86_64-pc-linux i386-pc-linux ; do

    (
      cd ${PKG_BUILD}/.${_grub_target}
        make CC=${CC} \
             AR=${AR} \
             RANLIB=${RANLIB} \
             CFLAGS="-I${TOOLCHAIN}/include -fomit-frame-pointer -D_FILE_OFFSET_BITS=64" \
             LDFLAGS="-L${TOOLCHAIN}/lib"
    )

  done
}

makeinstall_target() {
  _grub_modules="boot chain configfile ext2 fat linux search efi_gop efi_uga part_gpt gzio gettext loadenv loadbios memrw"

  for _grub_target in x86_64-pc-linux i386-pc-linux ; do
    case ${_grub_target} in
      x86_64-pc-linux)
        _efi_image_name="bootx64.efi"
        _efi_image_format="x86_64-efi"
        ;;
      i386-pc-linux)
        _efi_image_name="bootia32.efi"
        _efi_image_format="i386-efi"
	;;
    esac

    (
      cd ${PKG_BUILD}/.${_grub_target}/grub-core
        ../grub-mkimage -d . -o ${_efi_image_name} -O ${_efi_image_format} -p /EFI/BOOT ${_grub_modules}

        mkdir -p ${INSTALL}/usr/share/grub
          cp -P ${_efi_image_name} ${INSTALL}/usr/share/grub

        mkdir -p ${TOOLCHAIN}/share/grub
          cp -P ${_efi_image_name} ${TOOLCHAIN}/share/grub
    )

  done
}
