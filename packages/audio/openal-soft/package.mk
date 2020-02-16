# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="openal-soft"
PKG_VERSION="1.20.1"
PKG_SHA256="b6ceb051325732c23f5c8b6d37dbd89534517e6439a87e970882b447c3025d6d"
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
