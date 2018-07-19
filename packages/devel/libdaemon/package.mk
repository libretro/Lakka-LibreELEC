# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="libdaemon"
PKG_VERSION="0.14"
PKG_SHA256="fd23eb5f6f986dcc7e708307355ba3289abe03cc381fc47a80bca4a50aa6b834"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://0pointer.de/lennart/projects/libdaemon/"
PKG_URL="http://0pointer.de/lennart/projects/libdaemon/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="devel"
PKG_SHORTDESC="libdaemon: A lightweight C library which eases the writing of UNIX daemons"
PKG_LONGDESC="A wrapper around fork() which does the correct daemonization procedure of a process. A wrapper around syslog() for simpler and compatible log output to Syslog or STDERR. An API for writing PID files. An API for serializing UNIX signals into a pipe for usage with select() or poll()."

PKG_CONFIGURE_OPTS_TARGET="ac_cv_func_setpgrp_void=no \
                           --enable-static \
                           --disable-shared \
                           --disable-lynx"
