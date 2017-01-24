################################################################################
#      This file is part of LibreELEC - http://www.libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="openal-soft"
PKG_VERSION="1.17.2"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.openal.org/"
PKG_URL="http://kcat.strangesoft.net/openal-releases/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain alsa-lib"
PKG_SECTION="emulators/depends"
PKG_SHORTDESC="openal: Open Audio Library"
PKG_LONGDESC="OpenAL, the Open Audio Library, is a joint effort to create an open, vendor- neutral, cross-platform API for interactive, primarily spatialized audio. OpenAL's primary audience are application developers and desktop users that rely on portable standards like OpenGL, for games and other multimedia applications. OpenAL is already supported by a number of hardware vendors and developers."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CMAKE_OPTS_TARGET="-DALSOFT_EXAMPLES=off \
		       -DALSOFT_TESTS=off \
		       -DALSOFT_UTILS=off \
		       -DALSOFT_BACKEND_OSS=off \
		       -DALSOFT_BACKEND_WAVE=off \
		       -DALSOFT_BACKEND_PORTAUDIO=off \
		       -DALSOFT_BACKEND_PULSEAUDIO=off"

post_makeinstall_target() {
  mkdir -p $INSTALL/etc/openal
  sed s/^#drivers.*/drivers=alsa/ $INSTALL/usr/share/openal/alsoftrc.sample > $INSTALL/etc/openal/alsoft.conf
  rm -rf $INSTALL/usr/share/openal
}
