# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="bluez"
PKG_VERSION="5.66"
PKG_SHA256="39fea64b590c9492984a0c27a89fc203e1cdc74866086efb8f4698677ab2b574"
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

BLUEZ_CONFIG+=" --enable-monitor --enable-test"

PKG_CONFIGURE_OPTS_TARGET="--disable-dependency-tracking \
                           --disable-silent-rules \
                           --enable-library \
                           --enable-udev \
                           --disable-cups \
                           --disable-obex \
                           --enable-client \
                           --enable-systemd \
                           --enable-tools \
                           --enable-deprecated \
                           --enable-datafiles \
                           --disable-manpages \
                           --disable-experimental \
                           --enable-sixaxis \
                           --with-gnu-ld \
                           ${BLUEZ_CONFIG}"

# bluez had the good idea to use ':' in storage filenames, fat32 doesn't like that
if [ "${DEVICE}" = "Switch" ]; then
  PKG_CONFIGURE_OPTS_TARGET+=" storagedir=/var/bluetoothconfig"
else
  PKG_CONFIGURE_OPTS_TARGET+=" storagedir=/storage/.cache/bluetooth"
fi

pre_configure_target() {
# bluez fails to build in subdirs
  cd ${PKG_BUILD}
    rm -rf .${TARGET_NAME}
  sed -i -e "s|<policy user=\"%DISTRO%\">|<policy user=\"${DISTRO}\">|" src/bluetooth.conf
  export LIBS="-lncurses"
}

post_configure_target() {
  libtool_remove_rpath libtool
}

post_makeinstall_target() {
  safe_remove ${INSTALL}/usr/lib/systemd
  safe_remove ${INSTALL}/usr/bin/bluemoon
  safe_remove ${INSTALL}/usr/bin/ciptool
  safe_remove ${INSTALL}/usr/share/dbus-1

  mkdir -p ${INSTALL}/etc/bluetooth
    cp src/main.conf ${INSTALL}/etc/bluetooth
    sed -i ${INSTALL}/etc/bluetooth/main.conf \
        -e "s|^#\[Policy\]|\[Policy\]|g" \
        -e "s|^#AutoEnable.*|AutoEnable=true|g" \
        -e "s|^#JustWorksRepairing.*|JustWorksRepairing=always|g"

    if [ "${DISTRO}" = "Lakka" ] || [ "${PROJECT}" = "L4T" -a "${DEVICE}" = "Switch" ]; then
      sed -i $INSTALL/etc/bluetooth/main.conf \
          -e "s|^#FastConnectable.*|FastConnectable=true|g" \
          -e "s|^# Privacy =.*|Privacy = device|g"
    fi

  mkdir -p ${INSTALL}/usr/share/services
    cp -P ${PKG_DIR}/default.d/*.conf ${INSTALL}/usr/share/services

  # bluez looks in /etc/firmware/
    ln -sf /usr/lib/firmware ${INSTALL}/etc/firmware

  # pulseaudio checks for bluez via pkgconfig but lib is not actually needed
    sed -i 's/-lbluetooth//g' ${PKG_BUILD}/lib/bluez.pc
    cp -P ${PKG_BUILD}/lib/bluez.pc ${SYSROOT_PREFIX}/usr/lib/pkgconfig
}

post_install() {
  enable_service bluetooth-defaults.service
  enable_service bluetooth.service
  enable_service obex.service
}
