# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dbus-python"
PKG_VERSION="1.2.12"
PKG_SHA256="cdd4de2c4f5e58f287b12013ed7b41dee81d503c8d0d2397c5bd2fb01badf260"
PKG_LICENSE="GPL"
PKG_SITE="https://freedesktop.org/wiki/Software/dbus"
PKG_URL="https://dbus.freedesktop.org/releases/dbus-python/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3 dbus dbus-glib"
PKG_LONGDESC="D-BUS is a message bus, used for sending messages between applications."
PKG_BUILD_FLAGS="+lto"

pre_configure_target() {
  export PYTHON_CONFIG="$SYSROOT_PREFIX/usr/bin/python3-config"
  export PYTHON_INCLUDES="$($SYSROOT_PREFIX/usr/bin/python3-config --includes)"
  export PYTHON_LIBS="$($SYSROOT_PREFIX/usr/bin/python3-config --ldflags)"
}

post_makeinstall_target() {
  python_remove_source
}
