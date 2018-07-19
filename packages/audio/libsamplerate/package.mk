# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="libsamplerate"
PKG_VERSION="0.1.8"
PKG_SHA256="93b54bdf46d5e6d2354b7034395fe329c222a966790de34520702bb9642f1c06"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.mega-nerd.com/SRC/"
PKG_URL="http://www.mega-nerd.com/SRC/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="audio"
PKG_SHORTDESC="libsamplerate: A Sample Rate Converter library for audio"
PKG_LONGDESC="Libsamplerate is a Sample Rate Converter for audio. One example of where such a thing would be useful is converting audio from the CD sample rate of 44.1kHz to the 48kHz sample rate used by DAT players."

# package specific configure options
PKG_CONFIGURE_OPTS_TARGET="--disable-shared \
                           --enable-static \
                           --datadir=/usr/share \
                           --disable-fftw \
                           --disable-sndfile"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
