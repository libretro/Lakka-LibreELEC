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

PKG_NAME="xbmc"
PKG_VERSION="13-14b7a12"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.xbmc.org"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain boost Python zlib bzip2 systemd pciutils lzo pcre swig:host libass enca curl rtmpdump fontconfig fribidi gnutls tinyxml libjpeg-turbo libpng tiff freetype jasper libmad libsamplerate libogg libcdio libmodplug faad2 flac libmpeg2 taglib libxml2 libxslt yajl sqlite libvorbis"
PKG_PRIORITY="optional"
PKG_SECTION="mediacenter"
PKG_SHORTDESC="xbmc: XBMC Mediacenter"
PKG_LONGDESC="XBMC Media Center (which was formerly named Xbox Media Center) is a free and open source cross-platform media player and home entertainment system software with a 10-foot user interface designed for the living-room TV. Its graphical user interface allows the user to easily manage video, photos, podcasts, and music from a computer, optical disk, local network, and the internet using a remote control."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

# for dbus support
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET dbus"

# needed for hosttools (Texturepacker)
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET lzo:host SDL:host SDL_image:host"

if [ "$DISPLAYSERVER" = "x11" ]; then
# for libX11 support
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libX11 libXext"
# for libXrandr support
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libXrandr"
  XBMC_XORG="--enable-x11 --enable-xrandr"
else
  XBMC_XORG="--disable-x11 --disable-xrandr"
fi

if [ "$OPENGL" = "Mesa" ]; then
# for OpenGL (GLX) support
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET Mesa glu glew"
  XBMC_OPENGL="--enable-gl"
else
  XBMC_OPENGL="--disable-gl"
fi

if [ "$OPENGLES_SUPPORT" = yes ]; then
# for OpenGL-ES support
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OPENGLES"
  XBMC_OPENGLES="--enable-gles"
else
  XBMC_OPENGLES="--disable-gles"
fi

if [ "$SDL_SUPPORT" = yes ]; then
# for SDL support
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET SDL SDL_image"
  XBMC_SDL="--enable-sdl"
else
  XBMC_SDL="--disable-sdl"
fi

if [ "$ALSA_SUPPORT" = yes ]; then
# for ALSA support
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET alsa-lib"
  XBMC_ALSA="--enable-alsa"
else
  XBMC_ALSA="--disable-alsa"
fi

if [ "$PULSEAUDIO_SUPPORT" = yes ]; then
# for PulseAudio support
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET pulseaudio"
  XBMC_PULSEAUDIO="--enable-pulse"
else
  XBMC_PULSEAUDIO="--disable-pulse"
fi

if [ "$ESPEAK_SUPPORT" = yes ]; then
# for espeak support
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET espeak"
fi

if [ "$CEC_SUPPORT" = yes ]; then
# for CEC support
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libcec"
  XBMC_CEC="--enable-libcec"
else
  XBMC_CEC="--disable-libcec"
fi

if [ "$XBMC_SCR_RSXS" = yes ]; then
# for RSXS Screensaver support
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libXt libXmu"
  XBMC_RSXS="--enable-rsxs"
# fix build of RSXS Screensaver support if not using libiconv
  export jm_cv_func_gettimeofday_clobber=no
else
  XBMC_RSXS="--disable-rsxs"
fi

if [ "$XBMC_VIS_PROJECTM" = yes ]; then
# for ProjectM Visualisation support
  XBMC_PROJECTM="--enable-projectm"
else
  XBMC_PROJECTM="--disable-projectm"
fi

if [ "$XBMC_VIS_GOOM" = yes ]; then
# for GOOM Visualisation support
  XBMC_GOOM="--enable-goom"
else
  XBMC_GOOM="--disable-goom"
fi

if [ "$XBMC_VIS_WAVEFORM" = yes ]; then
# for Waveform Visualisation support
  XBMC_WAVEFORM="--enable-waveform"
else
  XBMC_WAVEFORM="--disable-waveform"
fi

if [ "$XBMC_VIS_SPECTRUM" = yes ]; then
# for Spectrum Visualisation support
  XBMC_SPECTRUM="--enable-spectrum"
else
  XBMC_SPECTRUM="--disable-spectrum"
fi

if [ "$XBMC_VIS_FISHBMC" = yes ]; then
# for FishBMC Visualisation support
  XBMC_FISHBMC="--enable-fishbmc"
else
  XBMC_FISHBMC="--disable-fishbmc"
fi

if [ "$JOYSTICK_SUPPORT" = yes ]; then
# for Joystick support
  XBMC_JOYSTICK="--enable-joystick"
else
  XBMC_JOYSTICK="--disable-joystick"
fi

if [ "$OPTICAL_DRIVE_SUPPORT" = yes ]; then
  XBMC_OPTICAL="--enable-optical-drive"
else
  XBMC_OPTICAL="--disable-optical-drive"
fi

if [ "$NONFREE_SUPPORT" = yes ]; then
# for non-free support
  XBMC_NONFREE="--enable-non-free"
else
  XBMC_NONFREE="--disable-non-free"
fi

if [ "$DVDCSS_SUPPORT" = yes ]; then
  XBMC_DVDCSS="--enable-dvdcss"
else
  XBMC_DVDCSS="--disable-dvdcss"
fi

if [ "$FAAC_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET faac"
fi

if [ "$ENCODER_LAME" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET lame"
  XBMC_LAMEENC="--enable-libmp3lame"
else
  XBMC_LAMEENC="--disable-libmp3lame"
fi

if [ "$BLURAY_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libbluray"
  XBMC_BLURAY="--enable-libbluray"
else
  XBMC_BLURAY="--disable-libbluray"
fi

if [ "$AVAHI_DAEMON" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET avahi"
  XBMC_AVAHI="--enable-avahi"
else
  XBMC_AVAHI="--disable-avahi"
fi

if [ "$MYSQL_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET mysql"
  XBMC_MYSQL="--enable-mysql"
else
  XBMC_MYSQL="--disable-mysql"
fi

if [ "$AIRPLAY_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libplist"
  XBMC_AIRPLAY="--enable-airplay"
else
  XBMC_AIRPLAY="--disable-airplay"
fi

if [ "$AIRTUNES_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libshairplay"
  XBMC_AIRTUNES="--enable-airtunes"
else
  XBMC_AIRTUNES="--disable-airtunes"
fi

if [ "$NFS_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libnfs"
  XBMC_NFS="--enable-nfs"
else
  XBMC_NFS="--disable-nfs"
fi

if [ "$AFP_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET afpfs-ng"
  XBMC_AFP="--enable-afpclient"
else
  XBMC_AFP="--disable-afpclient"
fi

if [ "$SAMBA_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET samba"
  XBMC_SAMBA="--enable-samba"
else
  XBMC_SAMBA="--disable-samba"
fi

if [ "$WEBSERVER" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libmicrohttpd"
  XBMC_WEBSERVER="--enable-webserver"
else
  XBMC_WEBSERVER="--disable-webserver"
fi

if [ "$UPNP_SUPPORT" = yes ]; then
  XBMC_UPNP="--enable-upnp"
else
  XBMC_UPNP="--disable-upnp"
fi

if [ "$SSHLIB_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libssh"
  XBMC_SSH="--enable-ssh"
else
  XBMC_SSH="--disable-ssh"
fi

if [ ! "$XBMCPLAYER_DRIVER" = default ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $XBMCPLAYER_DRIVER"

  if [ "$XBMCPLAYER_DRIVER" = bcm2835-driver ]; then
    XBMC_OPENMAX="--enable-openmax"
    XBMC_PLAYER="--enable-player=omxplayer"
    XBMC_CODEC="--with-platform=raspberry-pi"
    BCM2835_INCLUDES="-I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads/ \
                      -I$SYSROOT_PREFIX/usr/include/interface/vmcs_host/linux"
    XBMC_CFLAGS="$XBMC_CFLAGS $BCM2835_INCLUDES"
    XBMC_CXXFLAGS="$XBMC_CXXFLAGS $BCM2835_INCLUDES"
  elif [ "$XBMCPLAYER_DRIVER" = libfslvpuwrap ]; then
    XBMC_CODEC="--enable-codec=imxvpu"
  else
    XBMC_OPENMAX="--disable-openmax"
  fi
fi

if [ "$VDPAU" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libvdpau"
  XBMC_VDPAU="--enable-vdpau"
else
  XBMC_VDPAU="--disable-vdpau"
fi

if [ "$VAAPI" = yes ]; then
# configure GPU drivers and dependencies:
  get_graphicdrivers

  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $LIBVA"
  XBMC_VAAPI="--enable-vaapi"
else
  XBMC_VAAPI="--disable-vaapi"
fi

if [ "$CRYSTALHD" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET crystalhd"
  XBMC_CRYSTALHD="--enable-crystalhd"
else
  XBMC_CRYSTALHD="--disable-crystalhd"
fi

export CXX_FOR_BUILD="$HOST_CXX"
export CC_FOR_BUILD="$HOST_CC"
export CXXFLAGS_FOR_BUILD="$HOST_CXXFLAGS"
export CFLAGS_FOR_BUILD="$HOST_CFLAGS"
export LDFLAGS_FOR_BUILD="$HOST_LDFLAGS"

export PYTHON_VERSION="2.7"
export PYTHON_CPPFLAGS="-I$SYSROOT_PREFIX/usr/include/python$PYTHON_VERSION"
export PYTHON_LDFLAGS="-L$SYSROOT_PREFIX/usr/lib/python$PYTHON_VERSION -lpython$PYTHON_VERSION"
export PYTHON_SITE_PKG="$SYSROOT_PREFIX/usr/lib/python$PYTHON_VERSION/site-packages"
export ac_python_version="$PYTHON_VERSION"

PKG_CONFIGURE_OPTS_TARGET="gl_cv_func_gettimeofday_clobber=no \
                           ac_cv_lib_bluetooth_hci_devid=no \
                           --with-arch=$TARGET_ARCH \
                           --with-cpu=$TARGET_CPU \
                           --disable-debug \
                           --disable-optimizations \
                           $XBMC_OPENGL \
                           $XBMC_OPENGLES \
                           $XBMC_SDL \
                           $XBMC_OPENMAX \
                           $XBMC_VDPAU \
                           $XBMC_VAAPI \
                           $XBMC_CRYSTALHD \
                           --disable-xvba \
                           --disable-vdadecoder \
                           --disable-vtbdecoder \
                           --disable-tegra \
                           --disable-profiling \
                           $XBMC_JOYSTICK \
                           $XBMC_CEC \
                           --enable-udev \
                           --disable-libusb \
                           $XBMC_GOOM \
                           $XBMC_RSXS \
                           $XBMC_PROJECTM \
                           $XBMC_WAVEFORM \
                           $XBMC_SPECTRUM \
                           $XBMC_FISHBMC \
                           $XBMC_XORG \
                           --disable-ccache \
                           $XBMC_ALSA \
                           $XBMC_PULSEAUDIO \
                           --enable-rtmp \
                           $XBMC_SAMBA \
                           $XBMC_NFS \
                           $XBMC_AFP \
                           --enable-libvorbisenc \
                           --disable-libcap \
                           --enable-ffmpeg-libvorbis \
                           $XBMC_LAMEENC \
                           $XBMC_DVDCSS \
                           --disable-mid \
                           --disable-hal \
                           $XBMC_AVAHI \
                           $XBMC_UPNP \
                           $XBMC_MYSQL \
                           $XBMC_SSH \
                           $XBMC_AIRPLAY \
                           $XBMC_AIRTUNES \
                           $XBMC_NONFREE \
                           --disable-asap-codec \
                           $XBMC_WEBSERVER \
                           $XBMC_OPTICAL \
                           $XBMC_BLURAY \
                           --enable-texturepacker --with-texturepacker-root="$ROOT/$TOOLCHAIN" \
                           --disable-external-libraries \
                           $XBMC_CODEC \
                           $XBMC_PLAYER"

pre_build_target() {
# adding fake Makefile for stripped skin
  mkdir -p $PKG_BUILD/addons/skin.confluence/media
  touch $PKG_BUILD/addons/skin.confluence/media/Makefile.in

# autoreconf
  BOOTSTRAP_STANDALONE=1 make -C $PKG_BUILD -f bootstrap.mk
}

pre_configure_target() {
# xbmc fails to build in subdirs
  cd $ROOT/$PKG_BUILD
    rm -rf .$TARGET_NAME

# xbmc fails to build with LTO optimization if build without GOLD support
  [ ! "$GOLD_SUPPORT" = "yes" ] && strip_lto

# Todo: XBMC segfaults on exit when building with LTO support
  strip_lto

  export CFLAGS="$CFLAGS $XBMC_CFLAGS"
  export CXXFLAGS="$CXXFLAGS $XBMC_CXXFLAGS"
  export LIBS="$LIBS -lz"
}

make_target() {
# setup skin dir from default skin
  SKIN_DIR="skin.`tolower $SKIN_DEFAULT`"

# setup default skin inside the sources
  sed -i -e "s|skin.confluence|$SKIN_DIR|g" $ROOT/$PKG_BUILD/xbmc/settings/Settings.h

  make externals
  make xbmc.bin

  if [ "$DISPLAYSERVER" = "x11" ]; then
    make xbmc-xrandr
  fi

  make -C tools/TexturePacker
  cp -PR tools/TexturePacker/TexturePacker $ROOT/$TOOLCHAIN/bin
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin/xbmc
  rm -rf $INSTALL/usr/bin/xbmc-standalone
  rm -rf $INSTALL/usr/lib/xbmc/*.cmake

  mkdir -p $INSTALL/usr/lib/xbmc
    cp $PKG_DIR/scripts/xbmc-config $INSTALL/usr/lib/xbmc
    cp $PKG_DIR/scripts/xbmc-hacks $INSTALL/usr/lib/xbmc
    cp $PKG_DIR/scripts/xbmc-sources $INSTALL/usr/lib/xbmc

  mkdir -p $INSTALL/usr/lib/openelec
    cp $PKG_DIR/scripts/systemd-addon-wrapper $INSTALL/usr/lib/openelec

  mkdir -p $INSTALL/usr/bin
    cp $PKG_DIR/scripts/cputemp $INSTALL/usr/bin
      ln -sf cputemp $INSTALL/usr/bin/gputemp
    cp $PKG_DIR/scripts/setwakeup.sh $INSTALL/usr/bin
    cp tools/EventClients/Clients/XBMC\ Send/xbmc-send.py $INSTALL/usr/bin/xbmc-send

  if [ ! "$DISPLAYSERVER" = "x11" ]; then
    rm -rf $INSTALL/usr/lib/xbmc/xbmc-xrandr
  fi

  if [ ! "$XBMC_SCR_RSXS" = yes ]; then
    rm -rf $INSTALL/usr/share/xbmc/addons/screensaver.rsxs.*
  fi

  if [ ! "$XBMC_VIS_PROJECTM" = yes ]; then
    rm -rf $INSTALL/usr/share/xbmc/addons/visualization.projectm
  fi

  rm -rf $INSTALL/usr/share/applications
  rm -rf $INSTALL/usr/share/icons
  rm -rf $INSTALL/usr/share/xbmc/addons/repository.pvr-*
  rm -rf $INSTALL/usr/share/xbmc/addons/script.module.pysqlite
  rm -rf $INSTALL/usr/share/xbmc/addons/script.module.simplejson
  rm -rf $INSTALL/usr/share/xbmc/addons/visualization.dxspectrum
  rm -rf $INSTALL/usr/share/xbmc/addons/visualization.itunes
  rm -rf $INSTALL/usr/share/xbmc/addons/visualization.milkdrop
  rm -rf $INSTALL/usr/share/xbmc/addons/service.xbmc.versioncheck
  rm -rf $INSTALL/usr/share/xsessions

  mkdir -p $INSTALL/usr/share/xbmc/addons
    cp -R $PKG_DIR/config/os.openelec.tv $INSTALL/usr/share/xbmc/addons
    $SED "s|@OS_VERSION@|$OS_VERSION|g" -i $INSTALL/usr/share/xbmc/addons/os.openelec.tv/addon.xml
    cp -R $PKG_DIR/config/repository.openelec.tv $INSTALL/usr/share/xbmc/addons
    $SED "s|@ADDON_URL@|$ADDON_URL|g" -i $INSTALL/usr/share/xbmc/addons/repository.openelec.tv/addon.xml

  mkdir -p $INSTALL/usr/lib/python"$PYTHON_VERSION"/site-packages/xbmc
    cp -R tools/EventClients/lib/python/* $INSTALL/usr/lib/python"$PYTHON_VERSION"/site-packages/xbmc

# install project specific configs
  mkdir -p $INSTALL/usr/share/xbmc/config
    if [ -f $PROJECT_DIR/$PROJECT/xbmc/guisettings.xml ]; then
      cp -R $PROJECT_DIR/$PROJECT/xbmc/guisettings.xml $INSTALL/usr/share/xbmc/config
    fi

    if [ -f $PROJECT_DIR/$PROJECT/xbmc/sources.xml ]; then
      cp -R $PROJECT_DIR/$PROJECT/xbmc/sources.xml $INSTALL/usr/share/xbmc/config
    fi

  mkdir -p $INSTALL/usr/share/xbmc/system/
    if [ -f $PROJECT_DIR/$PROJECT/xbmc/advancedsettings.xml ]; then
      cp $PROJECT_DIR/$PROJECT/xbmc/advancedsettings.xml $INSTALL/usr/share/xbmc/system/
    else
      cp $PKG_DIR/config/advancedsettings.xml $INSTALL/usr/share/xbmc/system/
    fi

  mkdir -p $INSTALL/usr/share/xbmc/system/settings
    if [ -f $PROJECT_DIR/$PROJECT/xbmc/appliance.xml ]; then
      cp $PROJECT_DIR/$PROJECT/xbmc/appliance.xml $INSTALL/usr/share/xbmc/system/settings
    else
      cp $PKG_DIR/config/appliance.xml $INSTALL/usr/share/xbmc/system/settings
    fi

  if [ "$XBMC_EXTRA_FONTS" = yes ]; then
    mkdir -p $INSTALL/usr/share/xbmc/media/Fonts
      cp $PKG_DIR/fonts/*.ttf $INSTALL/usr/share/xbmc/media/Fonts
  fi
}

post_install() {
# link default.target to xbmc.target
  ln -sf xbmc.target $INSTALL/usr/lib/systemd/system/default.target

  enable_service xbmc-autostart.service
  enable_service xbmc-cleanlogs.service
  enable_service xbmc-config.service
  enable_service xbmc-hacks.service
  enable_service xbmc-sources.service
  enable_service xbmc-halt.service
  enable_service xbmc-poweroff.service
  enable_service xbmc-reboot.service
  enable_service xbmc-waitonnetwork.service
  enable_service xbmc.service
  enable_service xbmc-lirc-suspend.service
}
