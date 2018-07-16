# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gptfdisk"
PKG_VERSION="1.0.1"
PKG_SHA256="864c8aee2efdda50346804d7e6230407d5f42a8ae754df70404dd8b2fdfaeac7"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.rodsbooks.com/gdisk/"
PKG_URL="https://downloads.sourceforge.net/project/$PKG_NAME/$PKG_NAME/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain popt"
PKG_SECTION="system"
PKG_SHORTDESC="GPT text-mode partitioning tools"
PKG_LONGDESC="GPT text-mode partitioning tools"

make_target() {
  make sgdisk "CC=$CC" "CXX=$CXX"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/sbin/
    cp -p sgdisk $INSTALL/usr/sbin/
}
