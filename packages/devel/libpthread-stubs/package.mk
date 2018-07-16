# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="libpthread-stubs"
PKG_VERSION="0.4"
PKG_SHA256="50d5686b79019ccea08bcbd7b02fe5a40634abcfd4146b6e75c6420cc170e9d9"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://xcb.freedesktop.org/"
PKG_URL="http://xcb.freedesktop.org/dist/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="devel"
PKG_SHORTDESC="libpthread-stubs: A library providing weak aliases for pthread functions"
PKG_LONGDESC="This library provides weak aliases for pthread functions not provided in libc or otherwise available by default. Libraries like libxcb rely on pthread stubs to use pthreads optionally, becoming thread-safe when linked to libpthread, while avoiding any performance hit when running single-threaded."
