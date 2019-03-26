# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="qemu"
PKG_VERSION="3.1.0"
PKG_SHA256="6a0508df079a0a33c2487ca936a56c12122f105b8a96a44374704bef6c69abfc"
PKG_LICENSE="GPL"
PKG_SITE="http://wiki.qemu.org"
PKG_URL="https://download.qemu.org/qemu-$PKG_VERSION.tar.xz"
PKG_DEPENDS_HOST="toolchain glib:host pixman:host Python2:host zlib:host"
PKG_LONGDESC="QEMU is a generic and open source machine emulator and virtualizer."

pre_configure_host() {
  HOST_CONFIGURE_OPTS="--bindir=$TOOLCHAIN/bin \
                       --extra-cflags=-I$TOOLCHAIN/include \
                       --extra-ldflags=-L$TOOLCHAIN/lib \
                       --libexecdir=$TOOLCHAIN/lib \
                       --localstatedir=$TOOLCHAIN/var \
                       --prefix=$TOOLCHAIN \
                       --sbindir=$TOOLCHAIN/sbin \
                       --static \
                       --sysconfdir=$TOOLCHAIN/etc \
                       --disable-blobs \
                       --disable-docs \
                       --disable-gcrypt \
                       --disable-system \
                       --disable-user \
                       --disable-vnc \
                       --disable-werror"
}
