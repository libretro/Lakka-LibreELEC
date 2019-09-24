# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="bluez"
PKG_VERSION="5.51"
PKG_SHA256="ebedfb359f62957940822f1d0b39fcee30422380e435608dad06bb3913d5ebba"
PKG_LICENSE="GPL"
PKG_SITE="http://www.bluez.org/"
PKG_URL="https://www.kernel.org/pub/linux/bluetooth/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain dbus glib readline systemd"
PKG_LONGDESC="Bluetooth Tools and System Daemons for Linux."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+lto"

if build_with_debug; then
  BLUEZ_CONFIG="--enable-debug"
else
  BLUEZ_CONFIG="--disable-debug"
fi

BLUEZ_CONFIG="$BLUEZ_CONFIG --enable-monitor --enable-test"

PKG_CONFIGURE_OPTS_TARGET="--disable-dependency-tracking \
                           --disable-silent-rules \
                           --disable-library \
                           --enable-udev \
                           --disable-cups \
                           --disable-obex \
                           --enable-client \
                           --enable-systemd \
                           --enable-tools --enable-deprecated \
                           --enable-datafiles \
                           --disable-experimental \
                           --enable-sixaxis \
                           --with-gnu-ld \
                           $BLUEZ_CONFIG \
                           storagedir=/storage/.cache/bluetooth"

pre_configure_target() {
# bluez fails to build in subdirs
  cd $PKG_BUILD
    rm -rf .$TARGET_NAME

  export LIBS="-lncurses"
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/lib/systemd
  rm -rf $INSTALL/usr/bin/bccmd
  rm -rf $INSTALL/usr/bin/bluemoon
  rm -rf $INSTALL/usr/bin/ciptool
  rm -rf $INSTALL/usr/share/dbus-1

  mkdir -p $INSTALL/etc/bluetooth
    cp src/main.conf $INSTALL/etc/bluetooth
    sed -i $INSTALL/etc/bluetooth/main.conf \
        -e "s|^#\[Policy\]|\[Policy\]|g" \
        -e "s|^#AutoEnable.*|AutoEnable=true|g"

  mkdir -p $INSTALL/usr/share/services
    cp -P $PKG_DIR/default.d/*.conf $INSTALL/usr/share/services

  # bluez looks in /etc/firmware/
    ln -sf /usr/lib/firmware $INSTALL/etc/firmware
}

post_install() {
  enable_service bluetooth-defaults.service
  enable_service bluetooth.service
  enable_service obex.service
}
