# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="espeak-ng"
PKG_VERSION="1.51.1"
PKG_SHA256="0823df5648659dcb67915baaf99118dcc8853639f47cadaa029c174bdd768d20"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/espeak-ng/espeak-ng"
PKG_URL="https://github.com/espeak-ng/espeak-ng/archive/refs/tags/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="gcc:host"
PKG_DEPENDS_TARGET="toolchain espeak-ng:host"
PKG_LONGDESC="eSpeak NG is an open source speech synthesizer that supports more than a hundred languages and accents"
PKG_TOOLCHAIN="autotools"

make_host() {
  mkdir phsource dictsource
  (cd dictsource; ln -s ../../dictsource/* .)
  (cd phsource; ln -s ../../phsource/* .)
  cp -aP ../espeak-ng-data .
  make DESTDIR=$(pwd) -j1
}

make_target() {
  make src/espeak-ng src/speak-ng
}

makeinstall_target() {
  make src/espeak-ng src/speak-ng
  make install-exec DESTDIR=${INSTALL}
  mkdir -p ${INSTALL}/usr/share/espeak-ng-data
  cp -prf ${TOOLCHAIN}/share/espeak-ng-data ${INSTALL}/usr/share
}
