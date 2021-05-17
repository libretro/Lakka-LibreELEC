# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="bcm2835-bootloader"
PKG_VERSION="6c3d7745680f10802a7a5ed201e5252a3520e696"
PKG_SHA256="1228188fb19f915dbed5a4ac430107337ffd66b4f5b97801bd737a3257bb537c"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="http://www.broadcom.com"
PKG_URL="https://github.com/raspberrypi/firmware/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux bcmstat"
PKG_LONGDESC="bcm2835-bootloader: Tool to create a bootable kernel for RaspberryPi"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/bootloader
    cd boot
    cp -PRv LICENCE* $INSTALL/usr/share/bootloader
    cp -PRv bootcode.bin $INSTALL/usr/share/bootloader
    if [ "$DEVICE" = "RPi4" ]; then
      cp -PRv fixup4x.dat $INSTALL/usr/share/bootloader/fixup.dat
      cp -PRv fixup4.dat $INSTALL/usr/share/bootloader/fixup4.dat
      cp -PRv start4x.elf $INSTALL/usr/share/bootloader/start.elf
    else
      cp -PRv fixup_x.dat $INSTALL/usr/share/bootloader/fixup.dat
      cp -PRv start_x.elf $INSTALL/usr/share/bootloader/start.elf
      cp -PRv fixup4.dat $INSTALL/usr/share/bootloader/fixup4.dat
    fi

    find_file_path config/dt-blob.bin && cp -PRv $FOUND_PATH $INSTALL/usr/share/bootloader

    find_file_path bootloader/update.sh && cp -PRv $FOUND_PATH $INSTALL/usr/share/bootloader
    find_file_path bootloader/canupdate.sh && cp -PRv $FOUND_PATH $INSTALL/usr/share/bootloader

    find_file_path config/distroconfig.txt $PKG_DIR/files/3rdparty/bootloader/distroconfig.txt && cp -PRv ${FOUND_PATH} $INSTALL/usr/share/bootloader
    find_file_path config/config.txt $PKG_DIR/files/3rdparty/bootloader/config.txt && cp -PRv ${FOUND_PATH} $INSTALL/usr/share/bootloader

    # Enable 64-bit mode if ARCH is aarch64 and set kernel name
    if [ "$ARCH" = "aarch64" ]; then
      echo "arm_64bit=1" >> $INSTALL/usr/share/bootloader/distroconfig.txt
      echo "kernel=kernel.img" >> $INSTALL/usr/share/bootloader/distroconfig.txt
    fi

  cd ..
  # Install vendor header files except proprietary GL headers
  mkdir -p ${SYSROOT_PREFIX}/usr/include
    for f in $(cd hardfp/opt/vc/include; ls); do
      cp -PRv hardfp/opt/vc/include/$f ${SYSROOT_PREFIX}/usr/include
    done

  # Install vendor libs & pkgconfigs except proprietary GL libs
  mkdir -p ${SYSROOT_PREFIX}/usr/lib
    for f in $(cd hardfp/opt/vc/lib; ls *.so *.a ); do
      cp -PRv hardfp/opt/vc/lib/$f              ${SYSROOT_PREFIX}/usr/lib
    done
    mkdir -p ${SYSROOT_PREFIX}/usr/lib/pkgconfig
      for f in $(cd hardfp/opt/vc/lib/pkgconfig; ls ); do
        cp -PRv hardfp/opt/vc/lib/pkgconfig/$f  ${SYSROOT_PREFIX}/usr/lib/pkgconfig
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
    for f in $(cd hardfp/opt/vc/lib; ls *.so); do
      cp -PRv hardfp/opt/vc/lib/$f ${INSTALL}/usr/lib
    done

  # Install useful tools
  mkdir -p ${INSTALL}/usr/bin
    cp -PRv hardfp/opt/vc/bin/dtoverlay  ${INSTALL}/usr/bin
    ln -s dtoverlay                            ${INSTALL}/usr/bin/dtparam
    cp -PRv hardfp/opt/vc/bin/vcdbg      ${INSTALL}/usr/bin
    cp -PRv hardfp/opt/vc/bin/vcgencmd   ${INSTALL}/usr/bin
    cp -PRv hardfp/opt/vc/bin/vcmailbox  ${INSTALL}/usr/bin
    cp -PRv hardfp/opt/vc/bin/tvservice  ${INSTALL}/usr/bin
    cp -PRv hardfp/opt/vc/bin/edidparser ${INSTALL}/usr/bin

  # Create symlinks to /opt/vc to satisfy hardcoded lib paths
  mkdir -p ${INSTALL}/opt/vc
    ln -sf /usr/bin ${INSTALL}/opt/vc/bin
    ln -sf /usr/lib ${INSTALL}/opt/vc/lib
}
