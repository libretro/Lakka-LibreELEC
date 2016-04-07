################################################################################
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="protobuf"
PKG_VERSION="2.6.1"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="https://developers.google.com/protocol-buffers/"
PKG_URL="https://github.com/google/$PKG_NAME/releases/download/v$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="toolchain zlib"
PKG_DEPENDS_TARGET="toolchain zlib protobuf:host"
PKG_PRIORITY="optional"
PKG_SECTION="devel"
PKG_SHORTDESC="protobuf: Protocol Buffers - Google's data interchange format"
PKG_LONGDESC="protobuf: Protocol Buffers - Google's data interchange format"

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_HOST="--enable-static --disable-shared"
PKG_CONFIGURE_OPTS_TARGET="--disable-shared --enable-static --with-protoc=$ROOT/$TOOLCHAIN/bin/protoc"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin

  # HACK: we have protoc in $TOOLCHAIN/bin but it seems
  # the one from sysroot prefix is picked when building hyperion. remove it!
  rm -f $SYSROOT_PREFIX/usr/bin/protoc
}
