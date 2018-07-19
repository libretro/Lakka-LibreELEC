# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="dbus-python"
PKG_VERSION="1.2.8"
PKG_SHA256="abf12bbb765e300bf8e2a1b2f32f85949eab06998dbda127952c31cb63957b6f"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://freedesktop.org/wiki/Software/dbus"
PKG_URL="https://dbus.freedesktop.org/releases/dbus-python/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python2 dbus dbus-glib"
PKG_SECTION="python/system"
PKG_SHORTDESC="dbus-python: A message bus system"
PKG_LONGDESC="D-BUS is a message bus, used for sending messages between applications. Conceptually, it fits somewhere in between raw sockets and CORBA in terms of complexity. D-BUS supports broadcast messages, asynchronous messages (thus decreasing latency), authentication, and more. It is designed to be low-overhead; messages are sent using a binary protocol, not using XML. D-BUS also supports a method call mapping for its messages, but it is not required; this makes using the system quite simple."
PKG_BUILD_FLAGS="+lto"

pre_configure_target() {
  export PYTHON_CONFIG="$SYSROOT_PREFIX/usr/bin/python2-config"
  export PYTHON_INCLUDES="$($SYSROOT_PREFIX/usr/bin/python2-config --includes)"
  export PYTHON_LIBS="$($SYSROOT_PREFIX/usr/bin/python2-config --ldflags)"
}

post_makeinstall_target() {
  find $INSTALL/usr/lib -name "*.py" -exec rm -rf "{}" ";"
  find $INSTALL/usr/lib -name "*.pyc" -exec rm -rf "{}" ";"
}
