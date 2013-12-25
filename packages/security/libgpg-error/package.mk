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

PKG_NAME="libgpg-error"
PKG_VERSION="1.12"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnupg.org/"
PKG_URL="ftp://ftp.gnupg.org/gcrypt/libgpg-error/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS=""
PKG_BUILD_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="security"
PKG_SHORTDESC="libgpg-error: Library that defines common error values for GnuPG components"
PKG_LONGDESC="This is a library that defines common error values for all GnuPG components. Among these are GPG, GPGSM, GPGME, GPG-Agent, libgcrypt, Libksba, DirMngr, Pinentry, SmartCard Daemon and possibly more in the future."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--disable-nls --disable-rpath --with-gnu-ld"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
  rm -rf $INSTALL/usr/share

  sed -e "s:\(['= ]\)/usr:\\1$SYSROOT_PREFIX/usr:g" -i src/gpg-error-config
  cp src/gpg-error-config $ROOT/$TOOLCHAIN/bin
}
