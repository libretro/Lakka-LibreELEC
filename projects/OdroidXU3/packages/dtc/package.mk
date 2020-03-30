# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dtc"
PKG_VERSION="1.6.0"
PKG_SHA256="3d15dee7126a6c4a015ab47ec908cab13e39774b0315efaaebb223cb4a4d349c"
PKG_LICENSE="GPL"
PKG_SITE="https://git.kernel.org/pub/scm/utils/dtc/dtc.git/"
PKG_URL="https://git.kernel.org/pub/scm/utils/dtc/dtc.git/snapshot/dtc-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="Python2:host swig:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="The Device Tree Compiler"

PKG_MAKE_OPTS_HOST="dtc libfdt"
PKG_MAKE_OPTS_TARGET="dtc fdtput fdtget libfdt"

makeinstall_host() {
  mkdir -p $TOOLCHAIN/bin
    cp -P $PKG_BUILD/dtc $TOOLCHAIN/bin
    cp -P $PKG_BUILD/libfdt/libfdt-$PKG_VERSION.so $TOOLCHAIN/lib/libfdt.so
}

post_makeinstall_host() {
  python ./pylibfdt/setup.py build_ext --inplace
  exec_thread_safe python ./pylibfdt/setup.py install --prefix=$TOOLCHAIN
}

pre_make_target() {
  make clean BIN=
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp -P $PKG_BUILD/dtc $INSTALL/usr/bin
    cp -P $PKG_BUILD/fdtput $INSTALL/usr/bin/
    cp -P $PKG_BUILD/fdtget $INSTALL/usr/bin/
  mkdir -p $INSTALL/usr/lib
    cp -P $PKG_BUILD/libfdt/libfdt.so $INSTALL/usr/lib/
}
