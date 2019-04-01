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

PKG_NAME="game-hat"
PKG_VERSION="180720"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://www.waveshare.com/wiki/Game_HAT"
PKG_URL="https://www.waveshare.com/w/upload/b/b4/Game-HAT-$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="Game-HAT"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="driver"
PKG_SHORTDESC="Game HAT is a gaming console-like HAT for the Raspberry Pi with integrated buttons, audio, video and power control"

# TODO: Touch screen without X (is there even a touch screen on this thing?)
# TODO: fbcp useful for anything?
# TODO: inittab, used to recover from power failure?
# TODO: Port the package to RPi1 project (remove the RPI2 define)

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$TARGET_KERNEL_ARCH" = "arm64" -a "$TARGET_ARCH" = "arm" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET gcc-linaro-aarch64-elf:host"
  export PATH=$TOOLCHAIN/lib/gcc-linaro-aarch64-elf/bin/:$PATH
  TARGET_PREFIX=aarch64-elf-
fi

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  cd mk_arcade_joystick_rpi-master
  make V=1 \
       ARCH=$TARGET_KERNEL_ARCH \
       KERNELDIR=$(kernel_path) \
       CROSS_COMPILE=$TARGET_PREFIX \
       CONFIG_POWER_SAVING=n \
       ARCH="$ARCH" \
       CFLAGS_mk_arcade_joystick_rpi.o="-DRPI2" \
       -f Makefile.cross
}

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_module_dir)/$PKG_NAME
    cp $PKG_BUILD/mk_arcade_joystick_rpi-master/*.ko $INSTALL/$(get_full_module_dir)/$PKG_NAME

  mkdir -p $INSTALL/usr/share/bootloader/overlays/
    cp $PKG_BUILD/waveshare32b-overlay.dtb $INSTALL/usr/share/bootloader/overlays/waveshare32b-overlay.dtb
    cp $PKG_BUILD/waveshare32b-overlay.dtb $INSTALL/usr/share/bootloader/overlays/waveshare32b.dtbo
}
