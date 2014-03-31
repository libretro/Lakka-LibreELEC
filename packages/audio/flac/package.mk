################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="flac"
PKG_VERSION="1.3.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="http://flac.sourceforge.net/"
PKG_URL="http://downloads.xiph.org/releases/flac/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain libogg"
PKG_PRIORITY="optional"
PKG_SECTION="audio"
PKG_SHORTDESC="flac: An Free Lossless Audio Codec"
PKG_LONGDESC="Grossly oversimplified, FLAC is similar to MP3, but lossless, meaning that audio is compressed in FLAC without throwing away any information. This is similar to how Zip works, except with FLAC you will get much better compression because it is designed specifically for audio."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

# package specific configure options
PKG_CONFIGURE_OPTS_TARGET="--disable-rpath \
                           --disable-altivec \
                           --disable-doxygen-docs \
                           --disable-thorough-tests \
                           --disable-cpplibs \
                           --disable-xmms-plugin \
                           --disable-oggtest \
                           --with-ogg=$SYSROOT_PREFIX/usr \
                           --with-gnu-ld"

if [ $TARGET_ARCH = "i386" -o $TARGET_ARCH = "x86_64" ]; then
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --enable-sse"
else
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --disable-sse"
fi

pre_configure_target() {
# flac-1.3.0 fails to build with LTO support
  strip_lto
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
