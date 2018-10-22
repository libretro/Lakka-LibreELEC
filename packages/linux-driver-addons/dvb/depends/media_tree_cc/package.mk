# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="media_tree_cc"
PKG_VERSION="2018-08-17"
PKG_SHA256="1ffaafeeec85eece9697693efa22c8955a5ff63b7697eb0976f830ba92247147"
PKG_LICENSE="GPL"
PKG_SITE="https://bitbucket.org/CrazyCat/media_build/downloads/"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Source of Linux Kernel media_tree subsystem to build with media_build."
PKG_TOOLCHAIN="manual"

unpack() {
  mkdir -p $PKG_BUILD/
  tar -xf $SOURCES/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.bz2 -C $PKG_BUILD/

  # hack/workaround for borked upstream kernel/media_build
  # without removing atomisp there a lot additional includes that 
  # slowdown build process after modpost from 3min to 6min
  # even if atomisp is disabled via kernel.conf
  rm -rf $PKG_BUILD/drivers/staging/media/atomisp
  sed -i 's|^.*drivers/staging/media/atomisp.*$||' \
    $PKG_BUILD/drivers/staging/media/Kconfig
}
