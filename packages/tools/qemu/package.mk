################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016- Team LibreELEC
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

PKG_NAME="qemu"
PKG_VERSION="2.8.1"
PKG_SHA256="018e4c7ed22c220395cf41f835d01505e49d0e579a548bd3d72b03809442bbcd"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://wiki.qemu.org"
PKG_URL="http://wiki.qemu-project.org/download/qemu-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_HOST="toolchain Python2:host zlib:host glib:host"
PKG_SECTION="tools"
PKG_SHORTDESC="QEMU is a generic and open source machine emulator and virtualizer."
PKG_LONGDESC="QEMU is a generic and open source machine emulator and virtualizer."
PKG_AUTORECONF="no"

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
