# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mtpfs"
PKG_VERSION="fd3864d"
PKG_SHA256="f004136a82452d13362581277eb2496033aa13a6c3f35d0501327248f3120456"
PKG_LICENSE="GPL"
PKG_SITE="http://www.adebenham.com/mtpfs/"
PKG_URL="https://github.com/cjd/mtpfs/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain fuse libmtp glib"
PKG_LONGDESC="MTPfs is a FUSE filesystem that supports reading and writing from any MTP device."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--disable-mad"

# TODO: mtpfs runs host utils while building, fix and set 
pre_configure_target() {
  export LIBS="-lusb-1.0 -ludev"
}

makeinstall_target() {
  : # nop
}
