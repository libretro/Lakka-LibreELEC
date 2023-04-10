# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libgpiod"
PKG_VERSION="2.0"
PKG_SHA256="62071ac22872d9b936408e4a067d15edcdd61dce864ace8725eacdaefe23b898"
PKG_LICENSE="GPLv2+"
PKG_SITE="https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/about/"
PKG_URL="https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/snapshot/libgpiod-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Tools for interacting with the linux GPIO character device."
PKG_TOOLCHAIN="autotools"
PKG_CONFIGURE_OPTS_TARGET="--enable-tools --disable-shared"
