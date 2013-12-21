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

PKG_NAME="faad2"
PKG_VERSION="2.7"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.audiocoding.com/"
PKG_URL="$SOURCEFORGE_SRC/faac/faad2-src/$PKG_NAME-$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS=""
PKG_BUILD_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="audio"
PKG_SHORTDESC="faad: An MPEG-4 AAC decoder"
PKG_LONGDESC="The FAAD project includes the AAC decoder FAAD2. It supports several MPEG-4 object types (LC, Main, LTP, HE AAC, PS) and file formats (ADTS AAC, raw AAC, MP4), multichannel and gapless decoding as well as MP4 metadata tags. The codecs are compatible with standard-compliant audio applications using one or more of these profiles."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

# package specific configure options
PKG_CONFIGURE_OPTS_TARGET="--without-xmms \
                           --without-drm \
                           --without-mpeg4ip \
                           --with-gnu-ld"


post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
