################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="audioencoder.vorbis"
PKG_VERSION="fdca99b"
PKG_SHA256="8e5bfa7f3a2303e20826d27c278b62b3e57861dd5fa240ace58212e38eaf0a6a"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kodi.tv"
PKG_URL="https://github.com/xbmc/audioencoder.vorbis/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform libogg libvorbis"
PKG_SECTION=""
PKG_SHORTDESC="audioencoder.vorbis: A audioencoder addon for Kodi"
PKG_LONGDESC="audioencoder.vorbis is a audioencoder addon for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.audioencoder"
