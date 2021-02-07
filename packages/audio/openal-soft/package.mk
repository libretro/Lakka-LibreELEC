# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="openal-soft"
PKG_VERSION="1.21.1"
PKG_SHA256="8ac17e4e3b32c1af3d5508acfffb838640669b4274606b7892aa796ca9d7467f"
PKG_LICENSE="GPL"
PKG_SITE="http://www.openal.org/"
PKG_URL="https://github.com/kcat/openal-soft/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain:host"
PKG_DEPENDS_TARGET="toolchain openal-soft:host alsa-lib"
PKG_LONGDESC="OpenAL the Open Audio Library"

configure_package() {
  PKG_CMAKE_OPTS_HOST="-DALSOFT_BACKEND_OSS=off \
                       -DALSOFT_BACKEND_WAVE=off \
                       -DALSOFT_EXAMPLES=off \
                       -DALSOFT_TESTS=off \
                       -DALSOFT_UTILS=off"

  PKG_CMAKE_OPTS_TARGET="-DALSOFT_NATIVE_TOOLS_PATH=${PKG_BUILD}/.${HOST_NAME}/native-tools/ \
                         -DALSOFT_BACKEND_OSS=off \
                         -DALSOFT_BACKEND_WAVE=off \
                         -DALSOFT_BACKEND_PULSEAUDIO=off \
                         -DALSOFT_EXAMPLES=off \
                         -DALSOFT_TESTS=off \
                         -DALSOFT_UTILS=off"
}
