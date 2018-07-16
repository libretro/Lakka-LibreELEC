# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="xz"
PKG_VERSION="5.2.3"
PKG_SHA256="fd9ca16de1052aac899ad3495ad20dfa906c27b4a5070102a2ec35ca3a4740c1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://tukaani.org/xz/"
PKG_URL="http://tukaani.org/xz/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_HOST="ccache:host"
PKG_SECTION="toolchain/archivers"
PKG_SHORTDESC="xz: a free general-purpose data compression software with high compression ratio."
PKG_LONGDESC="XZ Utils is free general-purpose data compression software with high compression ratio. XZ Utils were written for POSIX-like systems, but also work on some not-so-POSIX systems. XZ Utils are the successor to LZMA Utils."

# never build shared or k0p happens when building
# on fedora due to host selinux/liblzma
PKG_CONFIGURE_OPTS_HOST="--disable-shared --enable-static \
                         --disable-lzmadec \
                         --disable-lzmainfo \
                         --enable-lzma-links \
                         --disable-scripts \
                         --disable-nls"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared --enable-static"

post_makeinstall_target() {
  rm -rf $INSTALL
}
