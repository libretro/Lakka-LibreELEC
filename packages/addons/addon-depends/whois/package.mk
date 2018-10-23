# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2011 Stephan Raue (stephan@openelec.tv)

PKG_NAME="whois"
PKG_VERSION="5.2.13"
PKG_SHA256="d7af1e89e7b3c63835e78bcea6c8aeb14640a3f1027f18b7b619a47100a6f2dc"
PKG_LICENSE="GPL"
PKG_SITE="http://www.linux.it/~md/software/"
PKG_URL="https://github.com/rfc1036/whois/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A tool that queries the whois directory service for information pertaining to a particular domain name."

make_target() {
  make mkpasswd
}

makeinstall_target() {
  : # nop
}
