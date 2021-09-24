# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

# fakeroot-1.20.2 depends on libcap:host, which depends on attr:host
# there are reported buildproblems with attr:host, which should be replicated
# use fakeroot-1.18.4 instead until attr:host builds

PKG_NAME="fakeroot"
PKG_VERSION="1.25.3"
PKG_SHA256="8e903683357f7f5bcc31b879fd743391ad47691d4be33d24a76be3b6c21e956c"
PKG_LICENSE="GPL3"
PKG_SITE="http://fakeroot.alioth.debian.org/"
PKG_URL="http://ftp.debian.org/debian/pool/main/f/fakeroot/${PKG_NAME}_${PKG_VERSION}.orig.tar.gz"
PKG_DEPENDS_HOST="ccache:host libcap:host autoconf:host libtool:host"
PKG_LONGDESC="fakeroot provides a fake root environment by means of LD_PRELOAD and SYSV IPC (or TCP) trickery."
PKG_TOOLCHAIN="configure"

PKG_CONFIGURE_OPTS_HOST="--with-gnu-ld"

pre_configure_host() {
  cd ${PKG_BUILD}
  ./bootstrap
}

