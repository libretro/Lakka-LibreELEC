# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="openal-soft"
PKG_VERSION="1.18.2"
PKG_SHA256="9f8ac1e27fba15a59758a13f0c7f6540a0605b6c3a691def9d420570506d7e82"
PKG_LICENSE="GPL"
PKG_SITE="http://www.openal.org/"
PKG_URL="http://kcat.strangesoft.net/openal-releases/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain alsa-lib"
PKG_LONGDESC="OpenAL the Open Audio Library"

PKG_CMAKE_OPTS_TARGET="-DALSOFT_BACKEND_OSS=off \
                       -DALSOFT_BACKEND_WAVE=off \
                       -DALSOFT_BACKEND_PULSEAUDIO=off \
                       -DALSOFT_EXAMPLES=off \
                       -DALSOFT_TESTS=off \
                       -DALSOFT_UTILS=off"
