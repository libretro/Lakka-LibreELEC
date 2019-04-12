# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="fluidsynth"
PKG_VERSION="1.1.6"
PKG_SHA256="d28b47dfbf7f8e426902ae7fa2981d821fbf84f41da9e1b85be933d2d748f601"
PKG_LICENSE="GPL"
PKG_SITE="http://fluidsynth.org/"
PKG_URL="$SOURCEFORGE_SRC/project/fluidsynth/fluidsynth-$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain glib"
PKG_LONGDESC="FluidSynth renders midi music files as raw audio data, for playing or conversion."
PKG_BUILD_FLAGS="+pic"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=0 \
                       -DLIB_SUFFIX= \
                       -Denable-readline=0 \
                       -Denable-pulseaudio=0 \
                       -Denable-libsndfile=0"
