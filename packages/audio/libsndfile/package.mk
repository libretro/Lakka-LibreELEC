################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="libsndfile"
PKG_VERSION="1.0.25"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.mega-nerd.com/libsndfile/"
PKG_URL="http://www.mega-nerd.com/$PKG_NAME/files/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain alsa-lib flac libvorbis libogg"
PKG_PRIORITY="optional"
PKG_SECTION="audio"
PKG_SHORTDESC="libsndfile: A library for accessing various audio file formats"
PKG_LONGDESC="libsndfile is a C library for reading and writing sound files such as AIFF, AU, WAV, and others through one standard interface. It can currently read/write 8, 16, 24 and 32-bit PCM files as well as 32 and 64-bit floating point WAV files and a number of compressed formats. It compiles and runs on *nix, MacOS, and Win32."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

# package specific configure options
PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared \
                           --disable-silent-rules \
                           --disable-sqlite \
                           --enable-alsa \
                           --enable-external-libs \
                           --disable-experimental \
                           --disable-test-coverage \
                           --enable-largefile \
                           --with-gnu-ld"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
