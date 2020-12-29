# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2011 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="whois"
PKG_VERSION="5.5.7"
PKG_SHA256="ae389c1486cdeae99f5f02940f98f5d7ff1f08ac0f96810365159b27b0189b5e"
PKG_LICENSE="GPL"
PKG_SITE="http://www.linux.it/~md/software/"
PKG_URL="https://github.com/rfc1036/whois/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A tool that queries the whois directory service for information pertaining to a particular domain name."
PKG_BUILD_FLAGS="-sysroot"

make_target() {
  make mkpasswd
}

makeinstall_target() {
  make install BASEDIR=$INSTALL
}
