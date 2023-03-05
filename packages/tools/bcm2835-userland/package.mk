# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="bcm2835-userland"
PKG_VERSION="54fd97ae4066a10b6b02089bc769ceed328737e0"
PKG_SHA256="b5718b34730069b7c3748cefb528696267c5bf9ba1e12df4f668640c50849125"
PKG_ARCH="arm aarch64"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://github.com/raspberrypi/userland"
PKG_URL="https://github.com/raspberrypi/userland/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="gcc:host"
PKG_LONGDESC="Source code for ARM side libraries for interfacing to Raspberry Pi GPU"
PKG_TOOLCHAIN="cmake"

if [ ${TARGET_ARCH} = "aarch64" ]; then
  PKG_CMAKE_OPTS_TARGET="-DARM64=ON"
else
  PKG_CMAKE_OPTS_TARGET="-DARM64=OFF"
fi

makeinstall_target() {
  # libraries used by below binaries
  mkdir -p ${INSTALL}/usr/lib
#    cp -PRv ${PKG_BUILD}/build/lib/libbcm_host.so ${INSTALL}/usr/lib
#    cp -PRv ${PKG_BUILD}/build/lib/libdebug_sym.so ${INSTALL}/usr/lib
    cp -PRv ${PKG_BUILD}/build/lib/libdtovl.so ${INSTALL}/usr/lib
    cp -PRv ${PKG_BUILD}/build/lib/libvchiq_arm.so ${INSTALL}/usr/lib
    cp -PRv ${PKG_BUILD}/build/lib/libvcos.so ${INSTALL}/usr/lib
#    cp -PRv ${PKG_BUILD}/build/lib/libdebug_sym_static.a ${INSTALL}/usr/lib
#    cp -PRv ${PKG_BUILD}/build/lib/libfdt.a ${INSTALL}/usr/lib
#    cp -PRv ${PKG_BUILD}/build/lib/libvchostif.a ${INSTALL}/usr/lib

  mkdir -p ${INSTALL}/usr/bin
    cp -PRv ${PKG_BUILD}/build/bin/dtoverlay ${INSTALL}/usr/bin
    ln -s dtoverlay                          ${INSTALL}/usr/bin/dtparam
    cp -PRv ${PKG_BUILD}/build/bin/vcgencmd  ${INSTALL}/usr/bin
    cp -PRv ${PKG_BUILD}/build/bin/vcmailbox ${INSTALL}/usr/bin
# tvservice does nothing when using vc4 driver
#    cp -PRv ${PKG_BUILD}/build/bin/tvservice ${INSTALL}/usr/bin
}
