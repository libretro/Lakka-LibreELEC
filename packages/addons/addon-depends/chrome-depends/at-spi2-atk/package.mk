# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017 Escalade
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="at-spi2-atk"
PKG_VERSION="2.26.2"
PKG_SHA256="61891f0abae1689f6617a963105a3f1dcdab5970c4a36ded9c79a7a544b16a6e"
PKG_LICENSE="OSS"
PKG_SITE="http://www.gnome.org/"
PKG_URL="https://ftp.gnome.org/pub/gnome/sources/at-spi2-atk/${PKG_VERSION:0:4}/at-spi2-atk-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain at-spi2-core atk libX11 libxml2"
PKG_LONGDESC="A GTK+ module that bridges ATK to D-Bus at-spi."
