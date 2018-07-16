# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libXext"
PKG_VERSION="1.3.3"
PKG_SHA256="b518d4d332231f313371fdefac59e3776f4f0823bcb23cf7c7305bfb57b16e35"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://xorg.freedesktop.org/archive/individual/lib/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros libX11"
PKG_SECTION="x11/lib"
PKG_SHORTDESC="libxext: X11 miscellaneous extensions library"
PKG_LONGDESC="LibXext provides an X Window System client interface to several extensions to the X protocol, iincluding DOUBLE-BUFFER (DBE), DPMS, Extended-Visual-Information (EVI), LBX, MIT-SHM, MIT-SUNDRY-NONSTANDARD, Multi-Buffering, SECURITY, SHAPE, SHAPE, SYNC, TOG-CUP, XC-APPGROUP, XC-MISC, XTEST and possibly others."

PKG_CONFIGURE_OPTS_TARGET="--enable-malloc0returnsnull --without-xmlto"
