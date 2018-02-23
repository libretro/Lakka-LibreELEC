################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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
PKG_VERSION="1.3.2"
PKG_SHA256="91cfc3ed61dc40f47f050a109b08610667d73477af6ef36dcad31c31a4a8d53f"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://xiph.org/flac/"
PKG_URL="http://downloads.xiph.org/releases/flac/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain libogg"
PKG_SECTION="audio"
PKG_SHORTDESC="flac: An Free Lossless Audio Codec"
PKG_LONGDESC="Grossly oversimplified, FLAC is similar to MP3, but lossless, meaning that audio is compressed in FLAC without throwing away any information. This is similar to how Zip works, except with FLAC you will get much better compression because it is designed specifically for audio."
PKG_TOOLCHAIN="autotools"
# flac-1.3.1 dont build with LTO support
PKG_BUILD_FLAGS="-lto +pic"

# package specific configure options
PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --disable-rpath \
                           --disable-altivec \
                           --disable-doxygen-docs \
                           --disable-thorough-tests \
                           --disable-cpplibs \
                           --disable-xmms-plugin \
                           --disable-oggtest \
                           --with-ogg=$SYSROOT_PREFIX/usr \
                           --with-gnu-ld"

if target_has_feature sse; then
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --enable-sse"
else
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --disable-sse"
fi

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
