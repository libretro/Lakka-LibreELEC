# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="hd-idle"
PKG_VERSION="1.05"
PKG_SHA256="4efefe79d145b50e055582730d9d685e485da3df3dad90fef030036d52aa3a0c"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://hd-idle.sourceforge.net/"
PKG_URL="http://downloads.sourceforge.net/project/hd-idle/${PKG_NAME}-${PKG_VERSION}.tgz"
PKG_SOURCE_DIR="$PKG_NAME"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="hd-idle is a [Linux] utility program for spinning-down external disks after a period of idle time."
PKG_LONGDESC="hd-idle is a utility program for spinning-down external disks after a period of idle time. Since most external IDE disk enclosures don't support setting the IDE idle timer, a program like hd-idle is required to spin down idle disks automatically."
