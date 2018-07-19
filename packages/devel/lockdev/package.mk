# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="lockdev"
PKG_VERSION="16b8996"
PKG_SHA256="49900093c12099047afa9f9d341da07b1a4a719e35c43db8409f65555ce09eb4"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://alioth.debian.org/scm/?group_id=100443"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="system"
PKG_SHORTDESC="lockdev: Manage character and block device lockfiles."
PKG_LONGDESC="lockdev manages character and block device lockfiles."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared"

post_makeinstall_target() {
  rm -rf $INSTALL/usr
}
