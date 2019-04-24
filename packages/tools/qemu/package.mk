# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="qemu"
PKG_VERSION="4.0.0"
PKG_SHA256="13a93dfe75b86734326f8d5b475fde82ec692d5b5a338b4262aeeb6b0fa4e469"
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
