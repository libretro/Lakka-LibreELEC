# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xf86-input-evdev"
PKG_VERSION="2.10.5"
PKG_SHA256="9edaa6205baf6d2922cc4db3d8e54a7e7773b5f733b0ae90f6be7725f983b70d"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://xorg.freedesktop.org/archive/individual/driver/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain xorg-server util-macros libevdev mtdev systemd"
PKG_LONGDESC="Evdev is an Xorg input driver for Linux's generic event devices."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--disable-silent-rules \
                           --with-xorg-module-dir=$XORG_PATH_MODULES \
                           --with-gnu-ld"
