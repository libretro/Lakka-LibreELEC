# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xorg-server"
PKG_VERSION="1.20.5"
PKG_SHA256="a81d8243f37e75a03d4f8c55f96d0bc25802be6ec45c3bfa5cb614c6d01bac9d"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://xorg.freedesktop.org/archive/individual/xserver/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros font-util xorgproto libpciaccess libX11 libXfont2 libXinerama libxshmfence libxkbfile libdrm openssl freetype pixman systemd xorg-launch-helper"
PKG_NEED_UNPACK="$(get_pkg_directory xf86-video-nvidia) $(get_pkg_directory xf86-video-nvidia-legacy)"
PKG_LONGDESC="Xorg is a full featured X server running on Intel x86 hardware."
PKG_TOOLCHAIN="autotools"

get_graphicdrivers

if [ "$COMPOSITE_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libXcomposite"
  XORG_COMPOSITE="--enable-composite"
else
  XORG_COMPOSITE="--disable-composite"
fi

if [ ! "$OPENGL" = "no" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OPENGL libepoxy"
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
                           --disable-xselinux \
                           $XORG_COMPOSITE \
                           --enable-mitshm \
                           --enable-xres \
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
      sed -i -e "s|@NVIDIA_VERSION@|$(get_pkg_version xf86-video-nvidia)|g" $INSTALL/usr/lib/xorg/xorg-configure
      sed -i -e "s|@NVIDIA_LEGACY_VERSION@|$(get_pkg_version xf86-video-nvidia-legacy)|g" $INSTALL/usr/lib/xorg/xorg-configure

  if [ ! "$OPENGL" = "no" ]; then
    if [ -f $INSTALL/usr/lib/xorg/modules/extensions/libglx.so ]; then
      mv $INSTALL/usr/lib/xorg/modules/extensions/libglx.so \
         $INSTALL/usr/lib/xorg/modules/extensions/libglx_mesa.so # rename for cooperate with nvidia drivers
      ln -sf /var/lib/libglx.so $INSTALL/usr/lib/xorg/modules/extensions/libglx.so
    fi
  fi

  mkdir -p $INSTALL/etc/X11
    if find_file_path config/xorg.conf ; then
      cp $FOUND_PATH $INSTALL/etc/X11
    fi
}

post_install() {
  enable_service xorg.service
}
