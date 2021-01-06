# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017 Escalade
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="cups"
PKG_VERSION="2.3.3"
PKG_SHA256="fe298713aad0cbb861de24760f140851122caae9f34d480dbfff0bd9211d961a"
PKG_LICENSE="GPL"
PKG_SITE="http://www.cups.org"
PKG_URL="https://github.com/apple/cups/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain openssl zlib"
PKG_LONGDESC="CUPS printing system."
PKG_BUILD_FLAGS="+pic -sysroot"

PKG_CONFIGURE_OPTS_TARGET="--libdir=/usr/lib \
                           --disable-gssapi \
                           --disable-avahi \
                           --disable-dnssd \
                           --disable-systemd \
                           --disable-launchd \
                           --disable-unit-tests"

pre_configure_target() {
  cd ..
  rm -rf .$TARGET_NAME
}

makeinstall_target() {
  make BUILDROOT="$INSTALL" install
}
