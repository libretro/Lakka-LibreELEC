# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="bcm2835-driver"
PKG_VERSION="1.20220120"
PKG_SHA256="67c49b6f2fbf4ee612536b3fc24e44ab3fa9584c78224865699f1cbc1b8eea3c"
PKG_LICENSE="nonfree"
PKG_SITE="http://www.broadcom.com"
# URL for commit hash
#PKG_URL="https://github.com/raspberrypi/firmware/archive/$PKG_VERSION.tar.gz"
# URL for release tag
PKG_URL="https://github.com/raspberrypi/firmware/archive/refs/tags/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain dtc"
PKG_LONGDESC="OpenMAX-bcm2835: OpenGL-ES and OpenMAX driver for BCM2835"
PKG_TOOLCHAIN="manual"

# Set SoftFP ABI or HardFP ABI
if [ "${TARGET_FLOAT}" = "soft" ]; then
  PKG_FLOAT="softfp"
else
  PKG_FLOAT="hardfp"
fi

makeinstall_target() {
  # Install vendor header files except proprietary GL headers
  mkdir -p ${SYSROOT_PREFIX}/usr/include
    for f in $(cd ${PKG_FLOAT}/opt/vc/include; ls); do
      cp -PRv ${PKG_FLOAT}/opt/vc/include/$f ${SYSROOT_PREFIX}/usr/include
    done

  # Install vendor libs & pkgconfigs except proprietary GL libs
  mkdir -p ${SYSROOT_PREFIX}/usr/lib
    for f in $(cd ${PKG_FLOAT}/opt/vc/lib; ls *.so *.a ); do
      cp -PRv ${PKG_FLOAT}/opt/vc/lib/$f              ${SYSROOT_PREFIX}/usr/lib
    done
    mkdir -p ${SYSROOT_PREFIX}/usr/lib/pkgconfig
      for f in $(cd ${PKG_FLOAT}/opt/vc/lib/pkgconfig; ls ); do
        cp -PRv ${PKG_FLOAT}/opt/vc/lib/pkgconfig/$f  ${SYSROOT_PREFIX}/usr/lib/pkgconfig
      done

  # Update prefix in vendor pkgconfig files
  for PKG_CONFIGS in $(find "${SYSROOT_PREFIX}/usr/lib" -type f -name "*.pc" 2>/dev/null); do
    sed -e "s#prefix=/opt/vc#prefix=/usr#g" -i "${PKG_CONFIGS}"
  done

  # Create symlinks to /opt/vc to satisfy hardcoded include & lib paths
  mkdir -p ${SYSROOT_PREFIX}/opt/vc
    ln -sf ${SYSROOT_PREFIX}/usr/lib     ${SYSROOT_PREFIX}/opt/vc/lib
    ln -sf ${SYSROOT_PREFIX}/usr/include ${SYSROOT_PREFIX}/opt/vc/include

  # Install vendor libs except proprietary GL
  mkdir -p ${INSTALL}/usr/lib
    for f in $(cd ${PKG_FLOAT}/opt/vc/lib; ls *.so); do
      cp -PRv ${PKG_FLOAT}/opt/vc/lib/$f ${INSTALL}/usr/lib
    done

  # Install useful tools
  mkdir -p ${INSTALL}/usr/bin
    cp -PRv ${PKG_FLOAT}/opt/vc/bin/dtoverlay  ${INSTALL}/usr/bin
    ln -s dtoverlay                            ${INSTALL}/usr/bin/dtparam
    cp -PRv ${PKG_FLOAT}/opt/vc/bin/vcdbg      ${INSTALL}/usr/bin
    cp -PRv ${PKG_FLOAT}/opt/vc/bin/vcgencmd   ${INSTALL}/usr/bin
    cp -PRv ${PKG_FLOAT}/opt/vc/bin/vcmailbox  ${INSTALL}/usr/bin
    cp -PRv ${PKG_FLOAT}/opt/vc/bin/tvservice  ${INSTALL}/usr/bin
    cp -PRv ${PKG_FLOAT}/opt/vc/bin/edidparser ${INSTALL}/usr/bin

  # Create symlinks to /opt/vc to satisfy hardcoded lib paths
  mkdir -p ${INSTALL}/opt/vc
    ln -sf /usr/bin ${INSTALL}/opt/vc/bin
    ln -sf /usr/lib ${INSTALL}/opt/vc/lib

  # remove pre-built binaries in case they will be provided by the rpi_userland package
  if listcontains "${ADDITIONAL_PACKAGES}" "rpi_userland" ; then
    rm -f ${INSTALL}/usr/lib/libbcm_host.so
    rm -f ${INSTALL}/usr/lib/libdebug_sym.so
    rm -f ${INSTALL}/usr/lib/libdtovl.so
    rm -f ${INSTALL}/usr/lib/libvchiq_arm.so
    rm -f ${INSTALL}/usr/lib/libvcos.so
    rm -f ${INSTALL}/usr/bin/dtmerge
    rm -f ${INSTALL}/usr/bin/dtoverlay
    rm -f ${INSTALL}/usr/bin/tvservice
    rm -f ${INSTALL}/usr/bin/vcgencmd
    rm -f ${INSTALL}/usr/bin/vchiq_test
    rm -f ${INSTALL}/usr/bin/vcmailbox
  fi
}
