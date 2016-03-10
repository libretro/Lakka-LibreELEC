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

PKG_NAME="pygobject"
PKG_VERSION="2.28.6"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.pygtk.org/"
PKG_URL="http://ftp.gnome.org/pub/GNOME/sources/pygobject/2.28/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain Python glib libffi"
PKG_PRIORITY="optional"
PKG_SECTION="python/devel"
PKG_SHORTDESC="pygobject: The Python bindings for GObject"
PKG_LONGDESC="PyGObject provides a convenient wrapper for the GObject+ library for use in Python programs, and takes care of many of the boring details such as managing memory and type casting. When combined with PyGTK, PyORBit and gnome-python, it can be used to write full featured Gnome applications."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--enable-thread --disable-introspection"

pre_configure_target() {
  export PYTHON_INCLUDES="$($SYSROOT_PREFIX/usr/bin/python2-config --includes)"
}

post_makeinstall_target() {
  find $INSTALL/usr/lib -name "*.py" -exec rm -rf "{}" ";"
  find $INSTALL/usr/lib -name "*.pyc" -exec rm -rf "{}" ";"

  rm -rf $INSTALL/usr/bin
  rm -rf $INSTALL/usr/share/pygobject
}
