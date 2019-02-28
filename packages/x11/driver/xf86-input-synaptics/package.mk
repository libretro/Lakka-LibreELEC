# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xf86-input-synaptics"
PKG_VERSION="1.9.1"
PKG_SHA256="7af83526eff1c76e8b9e1553b34245c203d029028d8044dd9dcf71eef1001576"
PKG_LICENSE="GPL"
PKG_SITE="http://lists.freedesktop.org/mailman/listinfo/xorg"
PKG_URL="http://xorg.freedesktop.org/archive/individual/driver/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain xorg-server libXi libXext libevdev"
PKG_LONGDESC="Synaptics touchpad driver for X.Org."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--with-xorg-module-dir=$XORG_PATH_MODULES"
