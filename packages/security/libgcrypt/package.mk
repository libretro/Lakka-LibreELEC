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

PKG_NAME="libgcrypt"
PKG_VERSION="1.8.1"
PKG_SHA256="7a2875f8b1ae0301732e878c0cca2c9664ff09ef71408f085c50e332656a78b3"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://www.gnupg.org/"
PKG_URL="https://www.gnupg.org/ftp/gcrypt/libgcrypt/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libgpg-error"
PKG_SECTION="security"
PKG_SHORTDESC="libgcrypt: General purpose cryptographic library"
PKG_LONGDESC="Libgcrypt is a general purpose cryptographic library based on the code from GnuPG. It provides functions for all cryptographic building blocks: symmetric ciphers, hash algorithms, MACs, public key algorithms, large integer functions, random numbers and a lot of supporting functions."
PKG_TOOLCHAIN="autotools"
# libgcrypt-1.7.x fails to build with LTO support
# see for example https://bugs.gentoo.org/show_bug.cgi?id=581114
PKG_BUILD_FLAGS="-lto"

PKG_CONFIGURE_OPTS_TARGET="CC_FOR_BUILD=$HOST_CC \
                           ac_cv_sys_symbol_underscore=no \
                           --enable-asm \
                           --with-gnu-ld \
                           --with-libgpg-error-prefix=$SYSROOT_PREFIX/usr \
                           --disable-doc"

post_makeinstall_target() {
  sed -e "s:\(['= ]\)\"/usr:\\1\"$SYSROOT_PREFIX/usr:g" -i src/$PKG_NAME-config
  cp src/$PKG_NAME-config $SYSROOT_PREFIX/usr/bin

  rm -rf $INSTALL/usr/bin
}
