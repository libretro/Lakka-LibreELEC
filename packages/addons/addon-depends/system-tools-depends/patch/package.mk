# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="patch"
PKG_VERSION="2.7.5"
PKG_SHA256="fd95153655d6b95567e623843a0e77b81612d502ecf78a489a4aed7867caa299"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://savannah.gnu.org/projects/patch/"
PKG_URL="http://ftpmirror.gnu.org/patch/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="GNU patch"
PKG_LONGDESC="Patch takes a patch file containing a difference listing produced by the diff program and applies those differences to one or more original files, producing patched versions"

PKG_CONFIGURE_OPTS_TARGET="--disable-xattr"

makeinstall_target() {
  : # nop
}
