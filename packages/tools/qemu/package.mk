# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="qemu"
PKG_VERSION="2.12.0"
PKG_SHA256="e69301f361ff65bf5dabd8a19196aeaa5613c1b5ae1678f0823bdf50e7d5c6fc"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://wiki.qemu.org"
PKG_URL="https://download.qemu.org/qemu-$PKG_VERSION.tar.xz"
PKG_DEPENDS_HOST="toolchain glib:host pixman:host Python2:host zlib:host"
PKG_SECTION="tools"
PKG_SHORTDESC="QEMU is a generic and open source machine emulator and virtualizer."
PKG_LONGDESC="QEMU is a generic and open source machine emulator and virtualizer."

HOST_CONFIGURE_OPTS="--prefix=$TOOLCHAIN \
  --bindir=$TOOLCHAIN/bin \
  --sbindir=$TOOLCHAIN/sbin \
  --sysconfdir=$TOOLCHAIN/etc \
  --libexecdir=$TOOLCHAIN/lib \
  --localstatedir=$TOOLCHAIN/var \
  --extra-cflags=-I$TOOLCHAIN/include \
  --extra-ldflags=-L$TOOLCHAIN/lib \
  --static \
  --disable-vnc \
  --disable-werror \
  --disable-blobs \
  --disable-system \
  --disable-user \
  --disable-docs"
