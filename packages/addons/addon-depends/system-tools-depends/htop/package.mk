# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="htop"
PKG_VERSION="3.1.1"
PKG_SHA256="b52280ad05a535ec632fbcd47e8e2c40a9376a9ddbd7caa00b38b9d6bb87ced6"
PKG_LICENSE="GPL"
PKG_SITE="https://hisham.hm/htop"
PKG_URL="https://github.com/htop-dev/htop/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain ncurses"
PKG_LONGDESC="An interactive process viewer for Unix."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_TARGET="--disable-unicode \
                           HTOP_NCURSES_CONFIG_SCRIPT=ncurses-config"

pre_configure_target() {
  export LDFLAGS="${LDFLAGS} -pthread"
}
