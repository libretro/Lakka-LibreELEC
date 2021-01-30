# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="edid-decode"
PKG_VERSION="770cfb947ea9d9eb5cda57a87dc66d13c60cfefc"
PKG_SHA256="eb6a766b89ef5f7d06d6649fc442ee57377ee7add801cde0a5ba6b636da78075"
PKG_LICENSE="None"
PKG_SITE="https://git.linuxtv.org/edid-decode.git/"
PKG_URL="https://repo.or.cz/edid-decode.git/snapshot/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Decode EDID data in human-readable format"

EDID_SOURCES="edid-decode.cpp parse-base-block.cpp parse-cta-block.cpp \
              parse-displayid-block.cpp parse-ls-ext-block.cpp \
              parse-di-ext-block.cpp parse-vtb-ext-block.cpp"

make_target() {
  echo "${CXX} ${CPPFLAGS} -Wall ${LDFLAGS} -g -DSHA=${PKG_VERSION:0:12} -o edid-decode ${EDID_SOURCES} -lm"
  ${CXX} ${CPPFLAGS} -Wall ${LDFLAGS} -g -DSHA=${PKG_VERSION:0:12} -o edid-decode ${EDID_SOURCES} -lm
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp edid-decode ${INSTALL}/usr/bin
}
