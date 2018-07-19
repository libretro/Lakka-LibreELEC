# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="make"
PKG_VERSION="4.2.1"
PKG_SHA256="d6e262bf3601b42d2b1e4ef8310029e1dcf20083c5446b4b7aa67081fdffc589"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://www.gnu.org/software/make/"
PKG_URL="http://ftpmirror.gnu.org/make/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_HOST=""
PKG_SECTION="toolchain/devel"
PKG_SHORTDESC="make: GNU make utility to maintain groups of programs"
PKG_LONGDESC="The 'make' utility automatically determines which pieces of a large program need to be recompiled, and issues commands to recompile them. This is GNU 'make', which was implemented by Richard Stallman and Roland McGrath. GNU 'make' conforms to section 6.2 of EEE Standard 1003.2-1992' (POSIX.2)."

export CC=$LOCAL_CC

post_makeinstall_host() {
  ln -sf make $TOOLCHAIN/bin/gmake
}
