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

PKG_NAME="speex"
PKG_VERSION="1.2rc1"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="http://www.speex.org"
PKG_URL="http://downloads.xiph.org/releases/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libogg"
PKG_PRIORITY="optional"
PKG_SECTION="audio"
PKG_SHORTDESC="speex: A free Audio Codec optimized for speech"
PKG_LONGDESC="Speex is a patent-free compression format designed especially for speech. It is specialized for voice communications at low bit-rates in the 2-45 kbps range. Possible applications include Voice over IP (VoIP), Internet audio streaming, audio books, and archiving of speech data (e.g. voice mail)."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

# package specific configure options
PKG_CONFIGURE_OPTS_TARGET="--disable-shared --enable-static \
                           --with-ogg=$SYSROOT_PREFIX/usr \
                           --enable-fixed-point \
                           --disable-oggtest \
                           --disable-float-api \
                           --disable-vbr"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
