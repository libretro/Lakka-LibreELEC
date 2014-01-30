################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="SDL_mixer"
PKG_VERSION="1.2.12"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.libsdl.org/"
PKG_URL="http://www.libsdl.org/projects/SDL_mixer/release/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain SDL libmad libogg"
PKG_PRIORITY="optional"
PKG_SECTION="multimedia"
PKG_SHORTDESC="libsdl_mixer: Simple Directmedia Layer - Mixer"
PKG_LONGDESC="SDL_mixer is a sound mixing library that is used with the SDL library, and almost as portable. It allows a programmer to use multiple samples along with music without having to code a mixing algorithm themselves. It also simplyfies the handling of loading and playing samples and music from all sorts of file formats."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="--disable-music-cmd \
                           --disable-music-wave \
                           --disable-music-mod \
                           --disable-music-midi \
                           --disable-music-timidity-midi \
                           --disable-music-native-midi \
                           --disable-music-native-midi-gpl \
                           --enable-music-ogg \
                           --enable-music-ogg-shared \
                           --disable-music-flac \
                           --disable-music-flac-shared \
                           --disable-music-mp3 \
                           --enable-music-mp3-shared \
                           --enable-music-mp3-mad-gpl \
                           --disable-smpegtest \
                           --with-gnu-ld \
                           --with-sdl-prefix=$SYSROOT_PREFIX/usr"
