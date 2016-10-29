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

PKG_NAME="kodi"
PKG_VERSION="17.0-beta5-e92818a"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kodi.tv"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain kodi:host xmlstarlet:host Python zlib systemd pciutils lzo pcre swig:host libass curl fontconfig fribidi tinyxml libjpeg-turbo freetype libcdio taglib libxml2 libxslt yajl sqlite ffmpeg crossguid giflib libdvdnav libhdhomerun"
PKG_DEPENDS_HOST="lzo:host libpng:host libjpeg-turbo:host giflib:host"
PKG_SECTION="mediacenter"
PKG_SHORTDESC="kodi: Kodi Mediacenter"
PKG_LONGDESC="Kodi Media Center (which was formerly named Xbox Media Center or XBMC) is a free and open source cross-platform media player and home entertainment system software with a 10-foot user interface designed for the living-room TV. Its graphical user interface allows the user to easily manage video, photos, podcasts, and music from a computer, optical disk, local network, and the internet using a remote control."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

# configure GPU drivers and dependencies:
  get_graphicdrivers

# for dbus support
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET dbus"

if [ "$DISPLAYSERVER" = "x11" ]; then
# for libX11 support
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libX11 libXext libdrm libXrandr"
  KODI_XORG="--enable-x11"
else
  KODI_XORG="--disable-x11"
fi

if [ ! "$OPENGL" = "no" ]; then
# for OpenGL (GLX) support
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OPENGL glu"
  KODI_OPENGL="--enable-gl"
else
  KODI_OPENGL="--disable-gl"
fi

if [ "$OPENGLES_SUPPORT" = yes ]; then
# for OpenGL-ES support
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OPENGLES"
  KODI_OPENGLES="--enable-gles"
else
  KODI_OPENGLES="--disable-gles"
fi

if [ "$ALSA_SUPPORT" = yes ]; then
# for ALSA support
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET alsa-lib"
  KODI_ALSA="--enable-alsa"
else
  KODI_ALSA="--disable-alsa"
fi

if [ "$PULSEAUDIO_SUPPORT" = yes ]; then
# for PulseAudio support
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET pulseaudio"
  KODI_PULSEAUDIO="--enable-pulse"
else
  KODI_PULSEAUDIO="--disable-pulse"
fi

if [ "$ESPEAK_SUPPORT" = yes ]; then
# for espeak support
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET espeak"
fi

if [ "$CEC_SUPPORT" = yes ]; then
# for CEC support
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libcec"
  KODI_CEC="--enable-libcec"
else
  KODI_CEC="--disable-libcec"
fi

if [ "$JOYSTICK_SUPPORT" = yes ]; then
# for Joystick support
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET SDL2"
  KODI_JOYSTICK="--enable-joystick"
else
  KODI_JOYSTICK="--disable-joystick"
fi

if [ "$KODI_OPTICAL_SUPPORT" = yes ]; then
  KODI_OPTICAL="--enable-optical-drive"
else
  KODI_OPTICAL="--disable-optical-drive"
fi

if [ "$KODI_NONFREE_SUPPORT" = yes ]; then
# for non-free support
  KODI_NONFREE="--enable-non-free"
else
  KODI_NONFREE="--disable-non-free"
fi

if [ "$KODI_DVDCSS_SUPPORT" = yes ]; then
  KODI_DVDCSS="--enable-dvdcss"
else
  KODI_DVDCSS="--disable-dvdcss"
fi

if [ "$KODI_BLURAY_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libbluray"
  KODI_BLURAY="--enable-libbluray"
else
  KODI_BLURAY="--disable-libbluray"
fi

if [ "$AVAHI_DAEMON" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET avahi nss-mdns"
  KODI_AVAHI="--enable-avahi"
else
  KODI_AVAHI="--disable-avahi"
fi

if [ "$KODI_MYSQL_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET mysql"
  KODI_MYSQL="--enable-mysql"
else
  KODI_MYSQL="--disable-mysql"
fi

if [ "$KODI_AIRPLAY_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libplist"
  KODI_AIRPLAY="--enable-airplay"
else
  KODI_AIRPLAY="--disable-airplay"
fi

if [ "$KODI_AIRTUNES_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libshairplay"
  KODI_AIRTUNES="--enable-airtunes"
else
  KODI_AIRTUNES="--disable-airtunes"
fi

if [ "$KODI_NFS_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libnfs"
  KODI_NFS="--enable-nfs"
else
  KODI_NFS="--disable-nfs"
fi

if [ "$KODI_SAMBA_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET samba"
  KODI_SAMBA="--enable-samba"
else
  KODI_SAMBA="--disable-samba"
fi

if [ "$KODI_WEBSERVER_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libmicrohttpd"
  KODI_WEBSERVER="--enable-webserver"
else
  KODI_WEBSERVER="--disable-webserver"
fi

if [ "$KODI_UPNP_SUPPORT" = yes ]; then
  KODI_UPNP="--enable-upnp"
else
  KODI_UPNP="--disable-upnp"
fi

if [ "$KODI_SSHLIB_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libssh"
  KODI_SSH="--enable-ssh"
else
  KODI_SSH="--disable-ssh"
fi

if [ ! "$KODIPLAYER_DRIVER" = default ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $KODIPLAYER_DRIVER"

  if [ "$KODIPLAYER_DRIVER" = bcm2835-driver ]; then
    KODI_OPENMAX="--enable-openmax"
    KODI_PLAYER="--enable-player=omxplayer"
    KODI_CODEC="--with-platform=raspberry-pi"
    BCM2835_INCLUDES="-I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads/ \
                      -I$SYSROOT_PREFIX/usr/include/interface/vmcs_host/linux"
    KODI_CFLAGS="$KODI_CFLAGS $BCM2835_INCLUDES"
    KODI_CXXFLAGS="$KODI_CXXFLAGS $BCM2835_INCLUDES"
  elif [ "$KODIPLAYER_DRIVER" = libfslvpuwrap ]; then
    KODI_CODEC="--enable-codec=imxvpu"
  elif [ "$KODIPLAYER_DRIVER" = libamcodec ]; then
    KODI_CODEC="--enable-codec=amcodec"
  else
    KODI_OPENMAX="--disable-openmax"
  fi
fi

if [ "$VDPAU_SUPPORT" = "yes" -a "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libvdpau"
  KODI_VDPAU="--enable-vdpau"
else
  KODI_VDPAU="--disable-vdpau"
fi

if [ "$VAAPI_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libva-intel-driver"
  KODI_VAAPI="--enable-vaapi"
else
  KODI_VAAPI="--disable-vaapi"
fi

export CXX_FOR_BUILD="$HOST_CXX"
export CC_FOR_BUILD="$HOST_CC"
export CXXFLAGS_FOR_BUILD="$HOST_CXXFLAGS"
export CFLAGS_FOR_BUILD="$HOST_CFLAGS"
export LDFLAGS_FOR_BUILD="$HOST_LDFLAGS"

export PYTHON_VERSION=2.7
export PYTHON_CPPFLAGS="-I$SYSROOT_PREFIX/usr/include/python$PYTHON_VERSION"
export PYTHON_LDFLAGS="-L$SYSROOT_PREFIX/usr/lib/python$PYTHON_VERSION -lpython$PYTHON_VERSION"
export PYTHON_SITE_PKG="$SYSROOT_PREFIX/usr/lib/python$PYTHON_VERSION/site-packages"

PKG_CONFIGURE_OPTS_TARGET="gl_cv_func_gettimeofday_clobber=no \
                           ac_python_version=$PYTHON_VERSION \
                           --disable-libbluetooth \
                           --disable-debug \
                           --disable-optimizations \
                           $KODI_OPENGL \
                           $KODI_OPENGLES \
                           $KODI_OPENMAX \
                           $KODI_VDPAU \
                           $KODI_VAAPI \
                           --disable-vtbdecoder \
                           --disable-tegra \
                           --disable-profiling \
                           $KODI_JOYSTICK \
                           $KODI_CEC \
                           --enable-udev \
                           --disable-libusb \
                           $KODI_XORG \
                           --disable-ccache \
                           $KODI_ALSA \
                           $KODI_PULSEAUDIO \
                           $KODI_SAMBA \
                           $KODI_NFS \
                           --disable-libcap \
                           $KODI_DVDCSS \
                           --disable-mid \
                           $KODI_AVAHI \
                           $KODI_UPNP \
                           $KODI_MYSQL \
                           $KODI_SSH \
                           $KODI_AIRPLAY \
                           $KODI_AIRTUNES \
                           --enable-gif \
                           $KODI_NONFREE \
                           --disable-asap-codec \
                           $KODI_WEBSERVER \
                           $KODI_OPTICAL \
                           $KODI_BLURAY \
                           --enable-texturepacker \
                           --with-ffmpeg=shared \
                           $KODI_CODEC \
                           $KODI_PLAYER"

pre_configure_host() {
# kodi fails to build in subdirs
  rm -rf $ROOT/$PKG_BUILD/.$HOST_NAME
}

configure_host() {
  : # not needed
}

make_host() {
  mkdir -p $ROOT/$PKG_BUILD/tools/depends/native/JsonSchemaBuilder/bin && cd $_
  cmake -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CONF \
        -DCMAKE_INSTALL_PREFIX=/usr \
        ..
  make
  mkdir -p $ROOT/$PKG_BUILD/tools/depends/native/TexturePacker/bin && cd $_
  cmake -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CONF \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCORE_SOURCE_DIR=$ROOT/$PKG_BUILD \
        -DCMAKE_CXX_FLAGS="-std=c++11 -DTARGET_POSIX -DTARGET_LINUX -D_LINUX -I$ROOT/$PKG_BUILD/xbmc/linux" \
        ..
  make
}

makeinstall_host() {
  cp -P $ROOT/$PKG_BUILD/tools/depends/native/TexturePacker/bin/TexturePacker $ROOT/$TOOLCHAIN/bin
}

pre_build_target() {
# adding fake Makefile for stripped skin
  mkdir -p $ROOT/$PKG_BUILD/addons/skin.estuary/media
  touch $ROOT/$PKG_BUILD/addons/skin.estuary/media/Makefile.in
}

pre_configure_target() {
# kodi fails to build in subdirs
  rm -rf $ROOT/$PKG_BUILD/.$TARGET_NAME

# kodi should never be built with lto
  strip_lto

  export CFLAGS="$CFLAGS $KODI_CFLAGS"
  export CXXFLAGS="$CXXFLAGS $KODI_CXXFLAGS"
  export LIBS="$LIBS -lz"

  export JSON_BUILDER=$ROOT/$TOOLCHAIN/bin/JsonSchemaBuilder

# libdvd
  cp -P $PKG_DIR/libdvd/libdvd-makefile.in $ROOT/$PKG_BUILD/lib/libdvd/Makefile.in
  export DVD_PREFIX="$SYSROOT_PREFIX"

# autoreconf
  BOOTSTRAP_STANDALONE=1 make -f $ROOT/$PKG_BUILD/bootstrap.mk
}

make_target() {
# setup skin dir from default skin
  SKIN_DIR="skin.`tolower $SKIN_DEFAULT`"

# setup default skin inside the sources
  sed -i -e "s|skin.estuary|$SKIN_DIR|g" $ROOT/$PKG_BUILD/xbmc/system.h
  sed -i -e "s|skin.estuary|$SKIN_DIR|g" $ROOT/$PKG_BUILD/system/settings/settings.xml

  make externals
  make kodi.bin

  if [ "$DISPLAYSERVER" = "x11" ]; then
    make kodi-xrandr
  fi
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin/kodi
  rm -rf $INSTALL/usr/bin/kodi-standalone
  rm -rf $INSTALL/usr/bin/xbmc
  rm -rf $INSTALL/usr/bin/xbmc-standalone
  rm -rf $INSTALL/usr/lib/kodi/*.cmake
  rm -rf $INSTALL/usr/share/applications
  rm -rf $INSTALL/usr/share/icons
  rm -rf $INSTALL/usr/share/kodi/addons/skin.estouchy
  rm -rf $INSTALL/usr/share/kodi/addons/service.xbmc.versioncheck
  rm -rf $INSTALL/usr/share/kodi/addons/visualization.vortex
  rm -rf $INSTALL/usr/share/xsessions

  mkdir -p $INSTALL/usr/lib/kodi
    cp $PKG_DIR/scripts/kodi-config $INSTALL/usr/lib/kodi
    cp $PKG_DIR/scripts/kodi.sh $INSTALL/usr/lib/kodi

  mkdir -p $INSTALL/usr/lib/libreelec
    cp $PKG_DIR/scripts/systemd-addon-wrapper $INSTALL/usr/lib/libreelec

  mkdir -p $INSTALL/usr/bin
    cp $PKG_DIR/scripts/cputemp $INSTALL/usr/bin
      ln -sf cputemp $INSTALL/usr/bin/gputemp
    cp $PKG_DIR/scripts/setwakeup.sh $INSTALL/usr/bin
    cp tools/EventClients/Clients/Kodi\ Send/kodi-send.py $INSTALL/usr/bin/kodi-send

  if [ ! "$DISPLAYSERVER" = "x11" ]; then
    rm -rf $INSTALL/usr/lib/kodi/kodi-xrandr
  fi

  mkdir -p $INSTALL/usr/share/kodi/addons
    cp -R $PKG_DIR/config/os.openelec.tv $INSTALL/usr/share/kodi/addons
    $SED "s|@OS_VERSION@|$OS_VERSION|g" -i $INSTALL/usr/share/kodi/addons/os.openelec.tv/addon.xml
    cp -R $PKG_DIR/config/os.libreelec.tv $INSTALL/usr/share/kodi/addons
    $SED "s|@OS_VERSION@|$OS_VERSION|g" -i $INSTALL/usr/share/kodi/addons/os.libreelec.tv/addon.xml
    cp -R $PKG_DIR/config/repository.libreelec.tv $INSTALL/usr/share/kodi/addons
    $SED "s|@ADDON_URL@|$ADDON_URL|g" -i $INSTALL/usr/share/kodi/addons/repository.libreelec.tv/addon.xml
    cp -R $PKG_DIR/config/repository.kodi.game $INSTALL/usr/share/kodi/addons

  mkdir -p $INSTALL/usr/lib/python$PYTHON_VERSION/site-packages/kodi
    cp -R tools/EventClients/lib/python/* $INSTALL/usr/lib/python$PYTHON_VERSION/site-packages/kodi

  mkdir -p $INSTALL/usr/share/kodi/config
    cp $PKG_DIR/config/guisettings.xml $INSTALL/usr/share/kodi/config
    cp $PKG_DIR/config/sources.xml $INSTALL/usr/share/kodi/config

# install project specific configs
    if [ -f $PROJECT_DIR/$PROJECT/kodi/guisettings.xml ]; then
      cp -R $PROJECT_DIR/$PROJECT/kodi/guisettings.xml $INSTALL/usr/share/kodi/config
    fi

    if [ -f $PROJECT_DIR/$PROJECT/kodi/sources.xml ]; then
      cp -R $PROJECT_DIR/$PROJECT/kodi/sources.xml $INSTALL/usr/share/kodi/config
    fi

  mkdir -p $INSTALL/usr/share/kodi/system/
    if [ -f $PROJECT_DIR/$PROJECT/kodi/advancedsettings.xml ]; then
      cp $PROJECT_DIR/$PROJECT/kodi/advancedsettings.xml $INSTALL/usr/share/kodi/system/
    else
      cp $PKG_DIR/config/advancedsettings.xml $INSTALL/usr/share/kodi/system/
    fi

  mkdir -p $INSTALL/usr/share/kodi/system/settings
    if [ -f $PROJECT_DIR/$PROJECT/kodi/appliance.xml ]; then
      cp $PROJECT_DIR/$PROJECT/kodi/appliance.xml $INSTALL/usr/share/kodi/system/settings
    else
      cp $PKG_DIR/config/appliance.xml $INSTALL/usr/share/kodi/system/settings
    fi

  # update addon manifest
  ADDON_MANIFEST=$INSTALL/usr/share/kodi/system/addon-manifest.xml
  xmlstarlet ed -L -d "/addons/addon[text()='service.xbmc.versioncheck']" $ADDON_MANIFEST
  xmlstarlet ed -L -d "/addons/addon[text()='skin.estouchy']" $ADDON_MANIFEST
  xmlstarlet ed -L --subnode "/addons" -t elem -n "addon" -v "repository.kodi.game" $ADDON_MANIFEST
  xmlstarlet ed -L --subnode "/addons" -t elem -n "addon" -v "os.libreelec.tv" $ADDON_MANIFEST
  xmlstarlet ed -L --subnode "/addons" -t elem -n "addon" -v "os.openelec.tv" $ADDON_MANIFEST
  xmlstarlet ed -L --subnode "/addons" -t elem -n "addon" -v "repository.libreelec.tv" $ADDON_MANIFEST
  xmlstarlet ed -L --subnode "/addons" -t elem -n "addon" -v "service.libreelec.settings" $ADDON_MANIFEST

  # more binaddons cross compile badness meh
  sed -i -e "s:INCLUDE_DIR /usr/include/kodi:INCLUDE_DIR $SYSROOT_PREFIX/usr/include/kodi:g" $SYSROOT_PREFIX/usr/lib/kodi/KodiConfig.cmake

  if [ "$KODI_EXTRA_FONTS" = yes ]; then
    mkdir -p $INSTALL/usr/share/kodi/media/Fonts
      cp $PKG_DIR/fonts/*.ttf $INSTALL/usr/share/kodi/media/Fonts
  fi

  debug_strip $INSTALL/usr/lib/kodi/kodi.bin
}

post_install() {
# link default.target to kodi.target
  ln -sf kodi.target $INSTALL/usr/lib/systemd/system/default.target

# enable default services
  enable_service kodi-autostart.service
  enable_service kodi-cleanlogs.service
  enable_service kodi-halt.service
  enable_service kodi-poweroff.service
  enable_service kodi-reboot.service
  enable_service kodi-waitonnetwork.service
  enable_service kodi.service
  enable_service kodi-lirc-suspend.service
}
