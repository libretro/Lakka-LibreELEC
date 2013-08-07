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

PKG_NAME="polkit"
PKG_VERSION="0.104"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="http://gitweb.freedesktop.org/?p=PolicyKit.git;a=summary"
PKG_URL="http://hal.freedesktop.org/releases/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS="zlib glib expat"
PKG_BUILD_DEPENDS_TARGET="toolchain zlib sg3_utils glib expat"
PKG_PRIORITY="optional"
PKG_SECTION="security"
PKG_SHORTDESC="polkit: Authorization Toolkit"
PKG_LONGDESC="PolicyKit is a toolkit for defining and handling authorizations. It is used for allowing unprivileged processes to speak to privileged processes."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--libexecdir=/usr/lib/polkit-1 \
                           --disable-man-pages \
                           --disable-gtk-doc \
                           --disable-nls \
                           --disable-introspection \
                           --disable-systemd \
                           --with-authfw=shadow \
                           --with-os-type=redhat \
                           --with-expat=$SYSROOT_PREFIX/usr"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin/pk-example-frobnicate
  rm -rf $INSTALL/usr/share/polkit-1/actions/org.freedesktop.policykit.examples.pkexec.policy
}

post_install() {
  echo "chmod 4755 $INSTALL/usr/bin/pkexec" >> $FAKEROOT_SCRIPT
  echo "chmod 4755 $INSTALL/usr/lib/polkit-1/polkit-agent-helper-1" >> $FAKEROOT_SCRIPT
}
