# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="qemu"
PKG_VERSION="2.12.0"
PKG_SHA256="e69301f361ff65bf5dabd8a19196aeaa5613c1b5ae1678f0823bdf50e7d5c6fc"
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
