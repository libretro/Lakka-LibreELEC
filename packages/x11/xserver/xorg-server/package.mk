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

PKG_NAME="xorg-server"
PKG_VERSION="1.19.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://xorg.freedesktop.org/archive/individual/xserver/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros font-util fontsproto randrproto recordproto renderproto dri2proto dri3proto fixesproto damageproto videoproto inputproto xf86dgaproto xf86vidmodeproto xf86driproto xf86miscproto presentproto libpciaccess libX11 libXfont2 libXinerama libxshmfence libxkbfile libdrm libressl freetype pixman fontsproto systemd xorg-launch-helper"
PKG_SECTION="x11/xserver"
PKG_SHORTDESC="xorg-server: The Xorg X server"
PKG_LONGDESC="Xorg is a full featured X server that was originally designed for UNIX and UNIX-like operating systems running on Intel x86 hardware."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

get_graphicdrivers

if [ "$COMPOSITE_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libXcomposite"
  XORG_COMPOSITE="--enable-composite"
else
  XORG_COMPOSITE="--disable-composite"
fi

if [ ! "$OPENGL" = "no" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET glproto $OPENGL libepoxy glu"
  XORG_MESA="--enable-glx --enable-dri --enable-glamor"
else
  XORG_MESA="--disable-glx --disable-dri --disable-glamor"
fi

PKG_CONFIGURE_OPTS_TARGET="--disable-debug \
                           --disable-silent-rules \
                           --disable-strict-compilation \
                           --enable-largefile \
                           --enable-visibility \
                           --disable-unit-tests \
                           --disable-sparkle \
                           --disable-install-libxf86config \
                           --disable-xselinux \
                           --enable-aiglx \
                           --enable-glx-tls \
                           $XORG_COMPOSITE \
                           --enable-mitshm \
                           --disable-xres \
                           --enable-record \
                           --enable-xv \
                           --disable-xvmc \
                           --enable-dga \
                           --disable-screensaver \
                           --disable-xdmcp \
                           --disable-xdm-auth-1 \
                           $XORG_MESA \
                           --enable-dri2 \
                           --enable-dri3 \
                           --enable-present \
                           --enable-xinerama \
                           --enable-xf86vidmode \
                           --disable-xace \
                           --disable-xselinux \
                           --disable-xcsecurity \
                           --disable-tslib \
                           --enable-dbe \
                           --disable-xf86bigfont \
                           --enable-dpms \
                           --enable-config-udev \
                           --enable-config-udev-kms \
                           --disable-config-hal \
                           --disable-config-wscons \
                           --enable-xfree86-utils \
                           --enable-vgahw \
                           --enable-vbe \
                           --enable-int10-module \
                           --disable-windowswm \
                           --enable-libdrm \
                           --enable-clientids \
                           --enable-pciaccess \
                           --disable-linux-acpi \
                           --disable-linux-apm \
                           --disable-systemd-logind \
                           --enable-xorg \
                           --disable-dmx \
                           --disable-xvfb \
                           --disable-xnest \
                           --disable-xquartz \
                           --disable-standalone-xpbproxy \
                           --disable-xwin \
                           --disable-kdrive \
                           --disable-xephyr \
                           --disable-xfake \
                           --disable-xfbdev \
                           --disable-kdrive-kbd \
                           --disable-kdrive-mouse \
                           --disable-kdrive-evdev \
                           --disable-libunwind \
                           --enable-xshmfence \
                           --disable-install-setuid \
                           --enable-unix-transport \
                           --disable-tcp-transport \
                           --disable-ipv6 \
                           --disable-local-transport \
                           --disable-secure-rpc \
                           --enable-input-thread \
                           --enable-xtrans-send-fds \
                           --disable-docs \
                           --disable-devel-docs \
                           --with-int10=x86emu \
                           --with-gnu-ld \
                           --with-sha1=libcrypto \
                           --without-systemd-daemon \
                           --with-os-vendor=LibreELEC.tv \
                           --with-module-dir=$XORG_PATH_MODULES \
                           --with-xkb-path=$XORG_PATH_XKB \
                           --with-xkb-output=/var/cache/xkb \
                           --with-log-dir=/var/log \
                           --with-fontrootdir=/usr/share/fonts \
                           --with-default-font-path=/usr/share/fonts/misc,built-ins \
                           --with-serverconfig-path=/usr/lib/xserver \
                           --without-xmlto \
                           --without-fop"

pre_configure_target() {
# hack to prevent a build error
  CFLAGS=`echo $CFLAGS | sed -e "s|-O3|-O2|" -e "s|-Ofast|-O2|"`
  LDFLAGS=`echo $LDFLAGS | sed -e "s|-O3|-O2|" -e "s|-Ofast|-O2|"`
}

post_makeinstall_target() {
  rm -rf $INSTALL/var/cache/xkb

  mkdir -p $INSTALL/usr/lib/xorg
    cp -P $PKG_DIR/scripts/xorg-configure $INSTALL/usr/lib/xorg
      . $ROOT/packages/x11/driver/xf86-video-nvidia/package.mk
      sed -i -e "s|@NVIDIA_VERSION@|${PKG_VERSION}|g" $INSTALL/usr/lib/xorg/xorg-configure
      . $ROOT/packages/x11/driver/xf86-video-nvidia-legacy/package.mk
      sed -i -e "s|@NVIDIA_LEGACY_VERSION@|${PKG_VERSION}|g" $INSTALL/usr/lib/xorg/xorg-configure
      . $ROOT/packages/x11/xserver/xorg-server/package.mk

  if [ ! "$OPENGL" = "no" ]; then
    if [ -f $INSTALL/usr/lib/xorg/modules/extensions/libglx.so ]; then
      mv $INSTALL/usr/lib/xorg/modules/extensions/libglx.so \
         $INSTALL/usr/lib/xorg/modules/extensions/libglx_mesa.so # rename for cooperate with nvidia drivers
      ln -sf /var/lib/libglx.so $INSTALL/usr/lib/xorg/modules/extensions/libglx.so
    fi
  fi

  mkdir -p $INSTALL/etc/X11
    if [ -f $PROJECT_DIR/$PROJECT/xorg/xorg.conf ]; then
      cp $PROJECT_DIR/$PROJECT/xorg/xorg.conf $INSTALL/etc/X11
    elif [ -f $PKG_DIR/config/xorg.conf ]; then
      cp $PKG_DIR/config/xorg.conf $INSTALL/etc/X11
    fi

  if [ ! "$DEVTOOLS" = yes ]; then
    rm -rf $INSTALL/usr/bin/cvt
    rm -rf $INSTALL/usr/bin/gtf
  fi
}

post_install() {
  enable_service xorg.service
}
