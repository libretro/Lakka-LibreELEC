# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mpd"
PKG_VERSION="0.20.21"
PKG_SHA256="8322764dc265c20f05c8c8fdfdd578b0722e74626bef56fcd8eebfb01acc58dc"
PKG_REV="106"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://www.musicpd.org"
PKG_URL="http://www.musicpd.org/download/mpd/${PKG_VERSION%.*}/mpd-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain alsa-lib boost curl faad2 ffmpeg flac glib lame libcdio libiconv libid3tag \
                    libmad libmpdclient libsamplerate libvorbis libnfs libogg mpd-mpc opus pulseaudio samba yajl"
PKG_SECTION="service.multimedia"
PKG_SHORTDESC="Music Player Daemon (MPD): a free and open Music Player Server"
PKG_LONGDESC="Music Player Daemon ($PKG_VERSION) is a flexible and powerful server-side application for playing music"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Music Player Daemon (MPD)"
PKG_ADDON_TYPE="xbmc.service"

PKG_CONFIGURE_OPTS_TARGET=" \
  --enable-aac \
  --disable-adplug \
  --enable-alsa \
  --disable-ao \
  --disable-audiofile \
  --enable-bzip2 \
  --disable-cdio-paranoia \
  --enable-cue \
  --enable-curl \
  --enable-database \
  --disable-debug \
  --disable-documentation \
  --enable-expat \
  --enable-ffmpeg \
  --enable-flac \
  --disable-fluidsynth \
  --disable-gme \
  --disable-haiku \
  --enable-httpd-output \
  --enable-iconv \
  --disable-icu \
  --enable-id3 \
  --enable-iso9660 \
  --disable-jack \
  --enable-lame-encoder \
  --enable-libmpdclient \
  --disable-libwrap \
  --enable-lsr \
  --enable-mad \
  --disable-mikmod \
  --disable-mms \
  --disable-modplug \
  --disable-mpc \
  --disable-mpg123 \
  --enable-nfs \
  --disable-openal \
  --enable-opus \
  --disable-oss \
  --enable-pipe-output \
  --enable-pulse \
  --disable-recorder-output \
  --disable-roar \
  --disable-shout \
  --disable-shine-encoder \
  --disable-sidplay \
  --enable-smbclient \
  --enable-sndfile \
  --disable-sndio \
  --disable-solaris-output \
  --enable-soundcloud \
  --enable-soxr \
  --enable-sqlite \
  --disable-syslog \
  --disable-systemd-daemon \
  --disable-test \
  --disable-twolame-encoder \
  --disable-upnp \
  --enable-vorbis \
  --enable-vorbis-encoder \
  --disable-wavpack \
  --enable-webdav \
  --disable-wildmidi \
  --enable-zlib \
  --with-zeroconf=no"

pre_configure_target() {
  export LIBS="$LIBS -logg -lFLAC -ldl"
}

makeinstall_target() {
  :
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $PKG_BUILD/.$TARGET_NAME/src/mpd $ADDON_BUILD/$PKG_ADDON_ID/bin
  # copy mpd cli binary
  cp -P $(get_build_dir mpd-mpc)/.$TARGET_NAME/mpc $ADDON_BUILD/$PKG_ADDON_ID/bin

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/lib
  cp -p $(get_build_dir libmpdclient)/.install_pkg/usr/lib/libmpdclient.so $ADDON_BUILD/$PKG_ADDON_ID/lib
  cp -p $(get_build_dir libmpdclient)/.install_pkg/usr/lib/libmpdclient.so.2 $ADDON_BUILD/$PKG_ADDON_ID/lib
}
