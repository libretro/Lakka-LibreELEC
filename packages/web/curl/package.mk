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

# Notes:
# - build curl with OpenSSL support instead GnuTLS support to 
#   work around a long standing bug on Pi where https streams often hang on
#   start. This hang is normally fatal and requires a reboot.
#   see also http://trac.xbmc.org/ticket/14674 .
#   Easiest way to reproduce is to install gdrive addon and play a video from
#   there: http://forum.xbmc.org/showthread.php?tid=177557
# - curl-7.35.0+ suffers from http://sourceforge.net/p/curl/bugs/1329/
#   see http://openelec.tv/forum/120-news-announcements/70230-beta-openelec-4-0-beta-4-released#102526
#   ERROR: CCurlFile::Stat - Failed: SSL connect error(35) for https://r3---sn-uxaxovg-5gos.googlevideo.com/videoplayback?ms=au&mt=1396702895&mv=m&id=o-ALo-Jz1LzwTiuQsF_PQdKzyWDm1Y423KOiPAk1wqHYrO&upn=PXY5TrK_TKk&ratebypass=yes&source=youtube&key=yt5&requiressl=yes&ipbits=0&sver=3&gcr=se&sparams=gcr,id,ip,ipbits,itag,ratebypass,requiressl,source,upn,expire&fexp=906399,909207,914088,916625,944603,937417,913434,936916,934022,936923&ip=213.112.234.108&itag=22&expire=1396727620&signature=688EA13BC8E378BD984F94336156EB3E90181B8F.5372D0B8B3650E6A8063B5148F9F4B353B0FA059
#   to test (dont work):
#   OpenELEC:~ # curl https://r3---sn-uxaxovg-5gos.googlevideo.com/videoplayback?ms=au&mt=1396702895&mv=m&id=o-ALo-Jz1LzwTiuQsF_PQdKzyWDm1Y423KOiPAk1wqHYrO&upn=PXY5TrK_TKk&ratebypass=yes&source=youtube&key=yt5&requiressl=yes&ipbits=0&sver=3&gcr=se&sparams=gcr,id,ip,ipbits,itag,ratebypass,requiressl,source,upn,expire&fexp=906399,909207,914088,916625,944603,937417,913434,936916,934022,936923&ip=213.112.234.108&itag=22&expire=1396727620&signature=688EA13BC8E378BD984F94336156EB3E90181B8F.5372D0B8B3650E6A8063B5148F9F4B353B0FA059
#   OpenELEC:~ # curl: (35) error:14077410:SSL routines:SSL23_GET_SERVER_HELLO:sslv3 alert handshake failure
#   to test (works):
#   OpenELEC:~ # curl --ciphers ALL https://r3---sn-uxaxovg-5gos.googlevideo.com/videoplayback?ms=au&mt=1396702895&mv=m&id=o-ALo-Jz1LzwTiuQsF_PQdKzyWDm1Y423KOiPAk1wqHYrO&upn=PXY5TrK_TKk&ratebypass=yes&source=youtube&key=yt5&requiressl=yes&ipbits=0&sver=3&gcr=se&sparams=gcr,id,ip,ipbits,itag,ratebypass,requiressl,source,upn,expire&fexp=906399,909207,914088,916625,944603,937417,913434,936916,934022,936923&ip=213.112.234.108&itag=22&expire=1396727620&signature=688EA13BC8E378BD984F94336156EB3E90181B8F.5372D0B8B3650E6A8063B5148F9F4B353B0FA059
#   OpenELEC:~ #

PKG_NAME="curl"
PKG_VERSION="7.34.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="http://curl.haxx.se"
PKG_URL="http://curl.haxx.se/download/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain zlib openssl rtmpdump"
PKG_PRIORITY="optional"
PKG_SECTION="web"
PKG_SHORTDESC="curl: Client and library for (HTTP, HTTPS, FTP, ...) transfers"
PKG_LONGDESC="Curl is a client to get documents/files from or send documents to a server, using any of the supported protocols (HTTP, HTTPS, FTP, FTPS, GOPHER, DICT, TELNET, LDAP or FILE). The command is designed to work without user interaction or any kind of interactivity."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_lib_rtmp_RTMP_Init=yes \
                           ac_cv_header_librtmp_rtmp_h=yes \
                           --disable-debug \
                           --enable-optimize \
                           --enable-warnings \
                           --disable-curldebug \
                           --disable-ares \
                           --enable-largefile \
                           --enable-http \
                           --enable-ftp \
                           --enable-file \
                           --disable-ldap \
                           --disable-ldaps \
                           --enable-rtsp \
                           --enable-proxy \
                           --disable-dict \
                           --disable-telnet \
                           --disable-tftp \
                           --disable-pop3 \
                           --disable-imap \
                           --disable-smtp \
                           --disable-gophper \
                           --disable-manual \
                           --enable-libgcc \
                           --enable-ipv6 \
                           --enable-versioned-symbols \
                           --enable-nonblocking \
                           --enable-threaded-resolver \
                           --enable-verbose \
                           --disable-sspi \
                           --enable-crypto-auth \
                           --enable-cookies \
                           --enable-hidden-symbols \
                           --disable-soname-bump \
                           --with-gnu-ld \
                           --without-krb4 \
                           --without-spnego \
                           --without-gssapi \
                           --with-zlib \
                           --without-egd-socket \
                           --enable-thread \
                           --with-random=/dev/urandom \
                           --without-gnutls \
                           --with-ssl \
                           --without-polarssl \
                           --without-nss \
                           --with-ca-bundle=$SSL_CERTIFICATES/cacert.pem \
                           --without-ca-path \
                           --without-libssh2 \
                           --with-librtmp=$SYSROOT_PREFIX/usr \
                           --without-libidn"

pre_configure_target() {
# link against librt because of undefined reference to 'clock_gettime'
  export LIBS="-lrt -lm -lrtmp"
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin/curl-config

  sed -e "s:\(['= ]\)/usr:\\1$SYSROOT_PREFIX/usr:g" -i $SYSROOT_PREFIX/usr/bin/curl-config
  mv $SYSROOT_PREFIX/usr/bin/curl-config $ROOT/$TOOLCHAIN/bin
}
