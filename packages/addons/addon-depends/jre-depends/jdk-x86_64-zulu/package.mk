# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Peter Vicman (peter.vicman@gmail.com)

PKG_NAME="jdk-x86_64-zulu"
PKG_VERSION="8.88.0.19-8.0.462"
PKG_SHA256="af194163bd9c870321f06b134f447869daafe6aef5b92b49d15b2fbc03a3b999"
PKG_LICENSE="GPLv2"
PKG_SITE="https://www.azul.com/products/zulu-enterprise/"
PKG_URL="https://cdn.azul.com/zulu/bin/zulu${PKG_VERSION%%-*}-ca-jdk${PKG_VERSION##*-}-linux_x64.tar.gz"
PKG_LONGDESC="Zulu, the open Java(TM) platform from Azul Systems."
PKG_TOOLCHAIN="manual"

post_unpack() {
  rm -f ${PKG_BUILD}/src.zip
}
