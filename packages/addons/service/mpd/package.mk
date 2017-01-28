################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="mpd"
PKG_VERSION="0.20.3"
PKG_REV="102"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://www.musicpd.org"
PKG_URL="http://www.musicpd.org/download/${PKG_NAME}/${PKG_VERSION%.*}/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain boost glib ffmpeg libmad libogg flac faad2 curl alsa-lib yajl libid3tag lame"
PKG_SECTION="service.multimedia"
PKG_SHORTDESC="Music Player Daemon (MPD): a free and open Music Player Server"
PKG_LONGDESC="Music Player Daemon ($PKG_VERSION) is a flexible and powerful server-side application for playing music"
PKG_AUTORECONF="no"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Music Player Daemon (MPD)"
PKG_ADDON_TYPE="xbmc.service"

pre_configure_target() {
  export LIBS="$LIBS -logg -lFLAC"
}

PKG_CONFIGURE_OPTS_TARGET="--enable-alsa \
             --disable-roar \
             --disable-ao \
             --disable-audiofile \
             --disable-bzip2 \
             --disable-cdio-paranoia \
             --enable-curl \
             --disable-smbclient \
             --disable-soup \
             --disable-debug \
             --disable-documentation \
             --disable-ffado \
             --enable-ffmpeg \
             --disable-fluidsynth \
             --disable-gme \
             --enable-httpd-output \
             --enable-id3 \
             --disable-jack \
             --disable-lastfm \
             --disable-despotify \
             --disable-soundcloud \
             --enable-lame-encoder \
             --disable-libwrap \
             --disable-lsr \
             --enable-mad \
             --disable-mikmod\
             --disable-mms \
             --disable-modplug \
             --disable-mpg123 \
             --disable-mvp \
             --disable-openal \
             --disable-oss \
             --disable-pipe-output \
             --disable-pulse \
             --disable-recorder-output \
             --disable-sidplay \
             --disable-shout \
             --disable-sndfile \
             --disable-solaris-output \
             --disable-sqlite \
             --disable-systemd-daemon \
             --disable-test \
             --disable-twolame-encoder \
             --disable-zzip \
             --with-zeroconf=no \
             --disable-icu"

makeinstall_target() {
  : # nop
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $PKG_BUILD/.$TARGET_NAME/src/mpd $ADDON_BUILD/$PKG_ADDON_ID/bin
}
